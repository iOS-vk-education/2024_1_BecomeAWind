import SwiftUI

final class EventsViewModel: ObservableObject, NavBarViewModelProtocol {

    @ObservedObject var db = TempDatabase.shared
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

    init() { updateEvents() }

    func updateEvents() {
        updateMyEvents()
        updateSubscriptions()
    }

    private func updateMyEvents() {
        myEvents = db.get(.my)
    }

    private func updateSubscriptions() {
        subscriptions = db.get(.subscriptions)
    }

}

/// nav bar
extension EventsViewModel {

    func centerButtonAction() {
        isActiveCreateEvent.toggle()
    }

    func changeActiveTabTo(_ tab: EventsTab) {
        activeTab = tab
    }

}

/// event card
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
