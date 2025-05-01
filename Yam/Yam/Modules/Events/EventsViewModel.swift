import SwiftUI
import FirebaseFirestore

final class EventsViewModel: ObservableObject {

    private let authInteractor = AuthInteractor.shared
    private let dbService = DatabaseService.shared

    @Published var myEvents: [Event] = []
    @Published var subscriptions: [Event] = []

    /// nav bar
    @Published var isActiveCreateEvent = false
    @Published var activeTab: EventsTab = .myEvents
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

        let result = isFirstPack
        ? await dbService.loadEvents(isMy: true, for: userID, lastDoc: nil)
        : await dbService.loadEvents(isMy: true, for: userID, lastDoc: lastDoc)
//        activeTab == .myEvents
//        ? await dbService.loadEvents(isMy: true, for: userID, lastDoc: lastDoc)
//        : await dbService.loadEvents(isMy: false, for: userID, lastDoc: lastDoc)

        if isFirstPack {
            myEvents = result.events
        } else {
            myEvents.append(contentsOf: result.events)
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
