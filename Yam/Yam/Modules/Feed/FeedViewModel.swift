import Foundation
import Combine
import SwiftUI
import FirebaseFirestore

final class FeedViewModel: ObservableObject {

    private let authInteractor = AuthInteractor.shared
    private let dbService = DatabaseService.shared

    @Published var events: [Event] = []

    /// TableFetchDataProtocol
    @Published var isLoadingMore = false
    var isRefreshing = false
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
        Task { await loadInitialItems() }
    }

}

extension FeedViewModel: TableFetchDataProtocol {

    typealias Item = Event

    @MainActor
    func loadInitialItems() async {
        isRefreshing = true

        let result = await dbService.loadFeed(lastDoc: nil)

        events = result.events
        lastDoc = result.newLastDoc
        isEndReached = result.isEndReached

        isRefreshing = false
    }

    @MainActor
    func loadNextPackItemsIfNeeded(currentItem item: Item) async {
        guard !isLoadingMore,
              !isEndReached,
              events.last?.id == item.id else { return }

        isLoadingMore = true

        let result = await dbService.loadFeed(lastDoc: lastDoc)

        events.append(contentsOf: result.events)
        lastDoc = result.newLastDoc
        isEndReached = result.isEndReached

        isLoadingMore = false
    }

    func refresh() async {
        guard !isRefreshing else { return }

        isRefreshing = true
        await loadInitialItems()
        isRefreshing = false
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
