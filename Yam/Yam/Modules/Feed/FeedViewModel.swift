import Foundation
import Combine
import SwiftUI
import FirebaseFirestore

final class FeedViewModel: ObservableObject {

    private let authInteractor = AuthInteractor.shared
    private let dbService = DatabaseService.shared

    @Published var events: [Event] = []
    var myEventsIDs: Set<String> = []

    /// TableFetchDataProtocol
    @Published var isLoading = false
    var isFirstPack = true
    var lastDoc: DocumentSnapshot? = nil
    var isEndReached = false {
        didSet {
            Task {
                await loadItems(isFirstPack: isFirstPack)
            }
        }
    }
    ///

    /// EventCardViewModelProtocol
    @Published var selectedEvent: Event?
    @Published var invalidLink = false
    @Published var isActiveEventLocation = false
    @Published var isActiveAction = false
    ///

    init() {
        Task {
            await loadItems(isFirstPack: isFirstPack)
        }
    }

    @MainActor
    private func getMyEventsIDs() async {
        guard let userID = authInteractor.getUserID() else { return }

        myEventsIDs = Set(await dbService.getMyEventsIDs(userID: userID))
    }

}

extension FeedViewModel: TableFetchDataProtocol {

    @MainActor
    func loadItems(isFirstPack: Bool) async {
        guard !isLoading,
              !isEndReached else { return }

        if isFirstPack { await getMyEventsIDs() }

        isLoading = true

        let result = isFirstPack
        ? await dbService.loadFeed(lastDoc: nil)
        : await dbService.loadFeed(lastDoc: lastDoc)

        if isFirstPack {
            events = result.events
        } else {
            events.append(contentsOf: result.events)
        }

        lastDoc = result.newLastDoc
        isEndReached = result.isEndReached

        isLoading = false

        if isFirstPack { self.isFirstPack = false }
    }


    @MainActor
    func refresh() async {
        guard !isLoading else { return }

        isLoading = true

        isFirstPack = true
        await loadItems(isFirstPack: isFirstPack)

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
