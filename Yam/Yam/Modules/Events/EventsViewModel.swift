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
    @Published var isLoadingMore = false
    var isRefreshing = false
    var lastDoc: DocumentSnapshot? = nil
    var isEndReached = false
    ///

    @MainActor
    func getEvents() {
        Task { [weak self] in
            guard let self else { return }

            let myEvents = await dbService.getEvents(my: true, userID: authInteractor.getUserID() ?? "")
            let subscriptions = await dbService.getEvents(my: false, userID: authInteractor.getUserID() ?? "")

            DispatchQueue.main.async {
                self.myEvents = myEvents
                self.subscriptions = subscriptions
            }
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
    typealias Item = Event

    func loadInitialItems() async {
        isRefreshing = true

//        await dbService.

        isRefreshing = false
    }

    func loadNextPackItemsIfNeeded(currentItem item: Item) async {

    }

    func refresh() async {

    }
    

}
