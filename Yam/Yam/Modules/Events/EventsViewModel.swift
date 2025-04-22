import SwiftUI

final class EventsViewModel: ObservableObject, NavBarViewModelProtocol {

    @ObservedObject var db = TempDatabase.shared
    @ObservedObject var model: EventsModel
    @Published var myEvents: [UIEvent] = []
    @Published var subscriptions: [UIEvent] = []

    /// nav bar
    @Published var isActiveCreateEvent = false
    @Published var activeTab: EventsTab = .myEvents
    var leftTab: EventsTab = .myEvents
    var rightTab: EventsTab = .subscriptions
    var isVisibleCenterButton: Bool = true

    /// event card
    @Published var selectedEvent: UIEvent?
    @Published var invalidLink = false
    @Published var isActiveEventLocation = false
    @Published var isActiveEditEvent = false

    init(model: EventsModel) {
        self.model = model
        getEvents()
    }

    func getEvents() {
        getMyEvents()
        getSubscriptions()
    }

    private func getMyEvents() {
        myEvents = db.get(.my)
    }

    private func getSubscriptions() {
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

    func toggleEdit(event: UIEvent) {
        selectedEvent = event
        isActiveEditEvent.toggle()
    }

    func toggleLocation(for event: UIEvent) {
        selectedEvent = event
        isActiveEventLocation.toggle()
    }

    func open(link: String) {
        if !EventHandler.openLink(link) {
            invalidLink.toggle()
        }
    }

    func handleSubscribeButton(for event: UIEvent) {}

    func convertToString(from seats: Seats) -> String {
        EventHandler.getSeatsString(from: seats)
    }

    func convertToString(from date: Date) -> String {
        EventHandler.getDateString(from: date)
    }

}
