import Foundation
import Combine
import SwiftUI
import FirebaseFirestore

final class FeedViewModel: ObservableObject {

    private let authInteractor = AuthInteractor.shared
    private let dbService = DatabaseService.shared

    @Published var events: [Event] = []
    var myEventsIDs: [String] = []

    /// TableFetchDataProtocol
    @Published var isLoading = false
    var lastDoc: DocumentSnapshot? = nil
    var isEndReached = false
    ///

    /// EventCardViewModelProtocol
    @Published var selectedEvent: Event?
    @Published var invalidLink = false
    @Published var isActiveEventLocation = false
    @Published var isActiveAction = false
    ///

    init() {
        Task {
            await loadItems(isInit: true)
        }
    }

    func getMyEventsIDs() async {
        guard let userID = authInteractor.getUserID() else { return }

        myEventsIDs = await dbService.getMyEventsIDs(userID: userID)
    }

}

extension FeedViewModel: TableFetchDataProtocol {

    @MainActor
    func loadItems(isInit: Bool) async {
        guard !isLoading,
              !isEndReached else { return }

        isLoading = true

        let result = isInit
        ? await dbService.loadFeed(lastDoc: nil)
        : await dbService.loadFeed(lastDoc: lastDoc)

        if isInit {
            events = result.events
        } else {
            events.append(contentsOf: result.events)
        }

        lastDoc = result.newLastDoc
        isEndReached = result.isEndReached

        isLoading = false
    }

    func refresh() async {
        guard !isLoading else { return }

        isLoading = true
        await loadItems(isInit: true)
        isLoading = false
    }

}

extension FeedViewModel: EventCardViewModelProtocol {

    func toggleAction(for event: Event) {}

    func toggleLocation(for event: Event) {
        selectedEvent = event
        isActiveEventLocation.toggle()
    }

    func open(link: String) {
        if !EventHandler.openLink(link) {
            invalidLink.toggle()
        }
    }

    func handleSubscribeButton(for event: Event) {}

}
