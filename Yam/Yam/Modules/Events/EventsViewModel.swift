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
    var lastDoc: DocumentSnapshot? = nil
    var isEndReached = false
    ///

    init() {
        Task {
            await loadItems(isInit: true)
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

    func handleSubscribeButton(for event: Event) {}

}

// MARK: - Table

extension EventsViewModel: TableFetchDataProtocol {

    @MainActor
    func loadItems(isInit: Bool) async {
        guard let userID = authInteractor.getUserID(),
              !isLoading,
              !isEndReached else { return }

        isLoading = true

        let result = isInit
        ? await dbService.loadEvents(isMy: true, for: userID, lastDoc: nil)
        : await dbService.loadEvents(isMy: true, for: userID, lastDoc: lastDoc)
//        activeTab == .myEvents
//        ? await dbService.loadEvents(isMy: true, for: userID, lastDoc: lastDoc)
//        : await dbService.loadEvents(isMy: false, for: userID, lastDoc: lastDoc)

        if isInit {
            myEvents = result.events
        } else {
            myEvents.append(contentsOf: result.events)
        }

        lastDoc = result.newLastDoc
        isEndReached = result.isEndReached

        isLoading = false
    }

    func refresh() async {
        guard !isLoading else { return }

        isLoading = true
        await loadItems(isInit: true)
        isLoading = false
    }
    
}
