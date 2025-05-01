import SwiftUI
import FirebaseFirestore

final class FeedViewModel: ObservableObject {

    private let authInteractor = AuthInteractor.shared
    @State var dbService = DatabaseService.shared

    @Published var events: [Event] = []

    /// EventCardViewModelProtocol
    @Published var selectedEvent: Event?
    @Published var invalidLink = false
    @Published var isActiveEventLocation = false
    @Published var isActiveAction = false
    ///

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

    @Published var failedToSubcribeAlert = false
    @Published var failedToUnsubcribeAlert = false


    init() {
        Task {
            await loadItems(isFirstPack: isFirstPack)
        }
    }

    private func getEventsIDs() async {
        guard let userID = authInteractor.getUserID() else { return }

        await dbService.getEventsIDs(userID: userID, my: true)
        await dbService.getEventsIDs(userID: userID, my: false)
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
    func handleSubscribeButton(event: Event, eventType: EventType) async -> Bool {
        guard let userID = authInteractor.getUserID() else { return false }

        selectedEvent = event

        switch eventType {
        case .added:
            guard let newEvent = await getNewEvent(
                userID: userID,
                event: event,
                eventType: eventType,
                subscriptionsContainsEvent: dbService.subscriptionsIDs.contains(event.id)
            ) else { return false }

            failedToUnsubcribeAlert = await !dbService.unsubscribeToTheEvent(
                userID: userID,
                event: newEvent
            )

            return !failedToUnsubcribeAlert

        case .notAdded:
            guard let newEvent = await getNewEvent(
                userID: userID,
                event: event,
                eventType: eventType,
                subscriptionsContainsEvent: dbService.subscriptionsIDs.contains(event.id)
            ) else { return false }

            failedToSubcribeAlert = await !dbService.subscribeToTheEvent(userID: userID, event: newEvent)

            return !failedToSubcribeAlert

        default: return false 
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
        guard !isLoading else { return }

        isLoading = true

        events.removeAll()
        isFirstPack = true
        lastDoc = nil
        isEndReached = false

        isLoading = false
    }

}
