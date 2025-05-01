import SwiftUI
import FirebaseFirestore

final class EventsViewModel: ObservableObject {

    private let authInteractor = AuthInteractor.shared
    private let dbService = DatabaseService.shared

    @Published var myEvents: [Event] = []
    @Published var subscriptions: [Event] = []

    /// nav bar
    @Published var isActiveCreateEvent = false
    @Published var activeTab: EventsTab = .myEvents {
        didSet {
            Task {
                await refresh()
            }
        }
    }
    var leftTab: EventsTab = .myEvents
    var rightTab: EventsTab = .subscriptions
    var isVisibleCenterButton: Bool = true

    /// EventCardViewModelProtocol
    @Published var selectedEvent: Event?
    @Published var invalidLink = false
    @Published var isActiveEventLocation = false
    @Published var isActiveAction = false
    @Published var failedToSubcribeAlert = false
    @Published var failedToUnsubcribeAlert = false
    ///

    /// TableFetchDataProtocol
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
    ///

    init() {
        Task {
            await loadItems(isFirstPack: isFirstPack)
        }
    }

    func getEventType(event: Event) -> EventType {
        switch activeTab {
        case .myEvents:
            .my
        case .subscriptions:
            if dbService.subscriptionsIDs.contains(event.id) {
                .added
            } else {
                .notAdded
            }
        }
    }

    private func getEventsIDs() async {
        guard let userID = authInteractor.getUserID() else { return }

        await dbService.getEventsIDs(userID: userID, my: false)
    }

}

// MARK: - NavBar

extension EventsViewModel: NavBarViewModelProtocol {

    func centerButtonAction() {
        isActiveCreateEvent.toggle()
    }

    func changeActiveTabTo(_ tab: EventsTab) {
        activeTab = tab
    }

}

// MARK: - EventCard

extension EventsViewModel: EventCardViewModelProtocol {

    func toggleAction(for event: Event) {
        selectedEvent = event
        isActiveAction.toggle()
    }

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
            
            switch activeTab {
            case .myEvents:
                if let index = myEvents.firstIndex(where: { $0.id == updatedEvent.id }) {
                    myEvents[index] = updatedEvent
                }
            case .subscriptions:
                if let index = subscriptions.firstIndex(where: { $0.id == updatedEvent.id }) {
                    subscriptions[index] = updatedEvent
                }
            }

            Logger.Feed.eventUpdated()
        } catch {
            Logger.Feed.eventNotUpdated(error)
        }
    }

}

// MARK: - Table

extension EventsViewModel: TableFetchDataProtocol {

    @MainActor
    func loadItems(isFirstPack: Bool) async {
        guard let userID = authInteractor.getUserID(),
              !isLoading,
              !isEndReached else { return }

        if isFirstPack {
            await getEventsIDs()
        }

        isLoading = true

        let result: (events: [Event], newLastDoc: DocumentSnapshot?, isEndReached: Bool)

        switch activeTab {
        case .myEvents:
            result = await dbService.loadEvents(isMy: true, for: userID, lastDoc: isFirstPack ? nil : lastDoc)
            myEvents = isFirstPack ? result.events : myEvents + result.events
        case .subscriptions:
            result = await dbService.loadEvents(isMy: false, for: userID, lastDoc: isFirstPack ? nil : lastDoc)
            subscriptions = isFirstPack ? result.events : subscriptions + result.events
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

        myEvents.removeAll()
        subscriptions.removeAll()
        isFirstPack = true
        lastDoc = nil
        isEndReached = false

        isLoading = false
    }

}
