import SwiftUI
import FirebaseFirestore

final class SubscriptionsViewModel: ObservableObject {

    private let authInteractor = AuthInteractor.shared
    private let dbService = DatabaseService.shared

    @Published var subscriptions: [Event] = []

    // EventCardViewModelProtocol
    @Published var selectedEvent: Event?
    @Published var invalidLink = false
    @Published var isActiveEventLocation = false
    @Published var isActiveBuildEvent = false
    @Published var subscribeFail = false
    @Published var unsubcribeFail = false
    @Published var fail = false

    // TableFetchDataProtocol
    @Published var isLoading = false
    var lastDoc: DocumentSnapshot? = nil
    var isEndReached = false
    var isFirstPack = true {
        didSet {
            Task {
                await loadItems(isFirstPack: isFirstPack)
            }
        }
    }

    init() {
        Task {
            await loadItems(isFirstPack: isFirstPack)
        }
    }

    func getEventType(event: Event) -> EventType {
        if dbService.subscriptionsIDs.contains(event.id) {
            return .added
        } else {
            return .notAdded
        }
    }

    private func getEventIDs() async {
        guard let userID = authInteractor.getUserID() else { return }

        await dbService.getEventIDs(userID: userID, my: false)
    }

}

// MARK: - EventCard

extension SubscriptionsViewModel: EventCardViewModelProtocol {

    func showBuildEvent(for event: Event) {}

    func showLocation(of event: Event) {
        selectedEvent = event
        isActiveEventLocation = true
    }

    func open(link: String) {
        if !EventHandler.openLink(link) {
            invalidLink = true
        }
    }

    @MainActor
    func handleSubscribeButton(event: Event, eventType: EventType) async -> Bool {
        guard let userID = authInteractor.getUserID() else {
            fail = true
            return !fail
        }

        selectedEvent = event

        switch eventType {
        case .added:
            guard let newEvent = await getNewEvent(
                userID: userID,
                event: event,
                eventType: eventType,
                subscriptionsContainsEvent: dbService.subscriptionsIDs.contains(event.id)
            ) else {
                unsubcribeFail = true
                return !subscribeFail
            }

            unsubcribeFail = await !dbService.unsubscribeToTheEvent(
                userID: userID,
                event: newEvent
            )

            return !unsubcribeFail

        case .notAdded:
            guard let newEvent = await getNewEvent(
                userID: userID,
                event: event,
                eventType: eventType,
                subscriptionsContainsEvent: dbService.subscriptionsIDs.contains(event.id)
            ) else {
                subscribeFail = true
                return !subscribeFail
            }

            subscribeFail = await !dbService.subscribeToTheEvent(userID: userID, event: newEvent)

            return !subscribeFail

        default:
            fail = true
            return !fail
        }
    }

    @MainActor
    func updateEvent(eventID: String) async {
        do {
            let updatedEvent = try await dbService.getEventFromFeed(by: eventID)

            await getEventIDs()

            if let index = subscriptions.firstIndex(where: { $0.id == updatedEvent.id }) {
                subscriptions[index] = updatedEvent
            }

            Logger.Feed.eventUpdated()
        } catch {
            Logger.Feed.eventNotUpdated(error)
        }
    }

}

// MARK: - Table

extension SubscriptionsViewModel: TableFetchDataProtocol {

    @MainActor
    func loadItems(isFirstPack: Bool) async {
        guard let userID = authInteractor.getUserID(),
              !isLoading,
              !isEndReached else { return }

        if isFirstPack {
            await getEventIDs()
        }

        isLoading = true

        let result: (events: [Event], newLastDoc: DocumentSnapshot?, isEndReached: Bool)
        result = await dbService.loadEvents(isMy: false, for: userID, lastDoc: isFirstPack ? nil : lastDoc)
        subscriptions = isFirstPack ? result.events : subscriptions + result.events

        lastDoc = result.newLastDoc
        isEndReached = result.isEndReached

        isLoading = false

        if isFirstPack { self.isFirstPack = false }
    }

    @MainActor
    func refresh() async {
        guard !isLoading else { return }

        isLoading = true

        subscriptions.removeAll()
        isFirstPack = true
        lastDoc = nil
        isEndReached = false

        isLoading = false
    }

}
