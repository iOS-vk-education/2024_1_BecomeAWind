import SwiftUI
import FirebaseFirestore

final class FeedViewModel: ObservableObject {

    private let authInteractor = AuthInteractor.shared
    private let dbService = DatabaseService.shared

    @Published var events: [Event] = []
    @Published var myEventsIDs: Set<String> = []
    @Published var subcriptionsIDs: Set<String> = []

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

    @Published var failedToSubcribeAlert = false
    @Published var failedToUnsubcribeAlert = false


    init() {
        Task {
            await loadItems(isFirstPack: isFirstPack)
        }
    }

    @MainActor
    func updateEvent(eventID: String) async {
        do {
            let updatedEvent = try await dbService.getEvent(by: eventID)
            await getEventsIDs()
            if let index = events.firstIndex(where: { $0.id == updatedEvent.id }) {
                events[index] = updatedEvent
            }
            Logger.Feed.eventUpdated()
        } catch {
            Logger.Feed.eventNotUpdated(error)
        }
    }


    @MainActor
    private func getEventsIDs() async {
        guard let userID = authInteractor.getUserID() else { return }

        myEventsIDs = Set(await dbService.getEventsIDs(userID: userID, isMyEvent: true))
        subcriptionsIDs = Set(await dbService.getEventsIDs(userID: userID, isMyEvent: false))
    }


}

extension FeedViewModel: TableFetchDataProtocol {

    @MainActor
    func loadItems(isFirstPack: Bool) async {
        guard !isLoading,
              !isEndReached else { return }

        if isFirstPack {
            await getEventsIDs()
        }

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
        func clearFeed() {
            events.removeAll()
            isFirstPack = true
            lastDoc = nil
            isEndReached = false
        }

        guard !isLoading else { return }

        isLoading = true

        clearFeed()
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

    @MainActor
    func handleSubscribeButton(for event: Event, eventType: EventType) async -> Bool {
        guard let userID = authInteractor.getUserID() else { return false }

        selectedEvent = event

        switch eventType {
        case .added:
            guard subcriptionsIDs.contains(event.id) &&
                event.seats.busy > 0 else {
                failedToUnsubcribeAlert = true
                return false
            }

            var newEvent = event
            newEvent.seats.busy -= 1

            failedToUnsubcribeAlert = await !dbService.unsubscribeToTheEvent(userID: userID, event: newEvent)

            return !failedToUnsubcribeAlert

        case .notAdded:
            guard !subcriptionsIDs.contains(event.id) &&
                event.seats.busy < event.seats.all else {
                failedToSubcribeAlert = true
                return false
            }

            var newEvent = event
            newEvent.seats.busy += 1

            failedToSubcribeAlert = await !dbService.subscribeToTheEvent(userID: userID, event: newEvent)

            return !failedToSubcribeAlert

        default: return false 
        }

    }

}
