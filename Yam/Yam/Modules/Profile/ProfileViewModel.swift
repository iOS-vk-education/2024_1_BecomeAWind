import SwiftUI

final class ProfileViewModel: ObservableObject, NavBarViewModelProtocol {

    @ObservedObject var db = TempDatabase.shared
    @Published var myEvents: [Event] = []
    @Published var subscriptions: [Event] = []

    /// nav bar
    @Published var isActiveCreateEvent = false
    @Published var activeTab: ProfileTab = .myEvents
    var leftTab: ProfileTab = .myEvents
    var rightTab: ProfileTab = .subscriptions

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
extension ProfileViewModel {

    func centerButtonAction() {
        isActiveCreateEvent.toggle()
    }

    func changeActiveTabTo(_ tab: ProfileTab) {
        activeTab = tab
    }

}

/// event card
extension ProfileViewModel: EventCardViewModelProtocol {

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
