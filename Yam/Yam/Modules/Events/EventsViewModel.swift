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
    ///

    /// TableFetchDataProtocol
    @Published var isLoading = false
    var isFirstPack = true {
        didSet {
            Task {
                await loadItems(isFirstPack: isFirstPack)
            }
        }
    }
    var lastDoc: DocumentSnapshot? = nil
    var isEndReached = false
    ///

    init() {
        Task {
            await loadItems(isFirstPack: isFirstPack)
        }
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

    func handleSubscribeButton(for event: Event, eventType: EventType) async -> Bool {
        return false
    }

    func updateEvent(eventID: String) async {}

}

// MARK: - Table

extension EventsViewModel: TableFetchDataProtocol {

    @MainActor
    func loadItems(isFirstPack: Bool) async {
        guard let userID = authInteractor.getUserID(),
              !isLoading,
              !isEndReached else { return }

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
