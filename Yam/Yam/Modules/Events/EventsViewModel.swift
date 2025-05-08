import SwiftUI
import FirebaseFirestore

final class EventsViewModel: ObservableObject {

    private let authInteractor = AuthInteractor.shared
    private let dbService = DatabaseService.shared

    @Published var myEvents: [Event] = []
    @Published var subscriptions: [Event] = []

    // NavBar
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
        switch activeTab {
        case .myEvents:
            return .my
        case .subscriptions:
            if dbService.subscriptionsIDs.contains(event.id) {
                return .added
            } else {
                print(event.id)
                print(dbService.subscriptionsIDs, terminator: "\n\n")
                return .notAdded
            }
        }
    }

    private func getEventIDs() async {
        guard let userID = authInteractor.getUserID() else { return }

        await dbService.getEventIDs(userID: userID, my: false)
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

    func showBuildEvent(for event: Event) {
        selectedEvent = event
        isActiveBuildEvent = true
    }

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

            if activeTab == .subscriptions {
                await getEventIDs()
            }

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
            await getEventIDs()
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
