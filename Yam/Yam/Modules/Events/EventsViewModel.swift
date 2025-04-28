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

    /// event card
    @Published var selectedEvent: Event?
    @Published var invalidLink = false
    @Published var isActiveEventLocation = false
    @Published var isActiveEditEvent = false

    @MainActor
    func getEvents() {
        Task { [weak self] in
            guard let self else { return }

            let myEvents = await dbService.getEvents(of: .my, userID: authInteractor.getUserID() ?? "")
            let subscriptions = await dbService.getEvents(of: .notMy, userID: authInteractor.getUserID() ?? "")

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

    func toggleEdit(event: Event) {
        selectedEvent = event
        isActiveEditEvent.toggle()
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

    func convertToString(from seats: Seats) -> String {
        EventHandler.getSeatsString(from: seats)
    }

    func convertToString(from date: Date) -> String {
        EventHandler.getDateString(from: date)
    }

}
