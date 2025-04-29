import SwiftUI

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

    /// EventCardViewModelProtocol conformance
    @Published var selectedEvent: Event?
    @Published var invalidLink = false
    @Published var isActiveEventLocation = false
    @Published var isActiveAction = false
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
