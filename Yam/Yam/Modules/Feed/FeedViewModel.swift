import Foundation
import Combine
import SwiftUI
import FirebaseFirestore

final class FeedViewModel: ObservableObject {

    private let authInteractor = AuthInteractor.shared
    private let dbService = DatabaseService.shared

    @Published var events: [Event] = []

    /// Events loading
    @Published var isLoadingMore = false
    private var isRefreshing = false
    private var lastDoc: DocumentSnapshot? = nil
    private var isEndReached = false
    ///

    /// EventCardViewModelProtocol conformance
    @Published var selectedEvent: Event?
    @Published var invalidLink = false
    @Published var isActiveEventLocation = false
    @Published var isActiveAction = false
    ///

    init() {
        Task { await loadInitialEvents() }
    }

    @MainActor
    private func loadInitialEvents() async {
        isRefreshing = true

        do {
            let query = dbService.getEventsCollection().order(by: "date", descending: false).limit(to: 3)
            let snapshot = try await query.getDocuments()
            let newEvents = try snapshot.documents.compactMap { try $0.data(as: Event.self) }

            events = newEvents
            lastDoc = snapshot.documents.last
            isEndReached = newEvents.isEmpty
        } catch {
            Logger.Feed.initialEventsLoadFail(error)
        }

        isRefreshing = false
    }

    @MainActor
    func loadMoreEventsIfNeeded(currentEvent event: Event) async {
        guard !isLoadingMore,
              let last = lastDoc,
              !isEndReached,
              events.last?.id == event.id else { return }

        isLoadingMore = true

        do {
            let query = dbService.getEventsCollection()
                .order(by: "date", descending: false)
                .start(afterDocument: last)
                .limit(to: 3)

            let snapshot = try await query.getDocuments()
            let newEvents = try snapshot.documents.compactMap { try $0.data(as: Event.self) }

            events.append(contentsOf: newEvents)
            lastDoc = snapshot.documents.last
            isEndReached = newEvents.isEmpty
        } catch {
            Logger.Feed.nextPackEventsLoadFail(error)
        }

        isLoadingMore = false
    }

    func refresh() async {
        guard !isRefreshing else { return }

        isRefreshing = true
        await loadInitialEvents()
        isRefreshing = false
    }
    
//
//    @MainActor
//    func getFeed() async {
//        let allEvents = await dbService.getAllEvents()
//        self.allEvents = allEvents
//    }

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
