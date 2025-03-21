import SwiftUI

final class ProfileViewModel: ObservableObject {

    @ObservedObject var db = TempDatabase.shared

    /// top tab bar
    @Published var activeTab: ProfileTab = .myEvents
    @Published var isActiveCreateEvent = false

    /// event card
    @Published var selectedEvent: Event?
    @Published var invalidLink = false
    @Published var isActiveEventLocation = false
    @Published var isActiveEditEvent = false

}

/// top tab bar
extension ProfileViewModel {

    func toggleCreateEvent() {
        isActiveCreateEvent.toggle()
    }

    func changeActiveTabTo(_ tab: ProfileTab) {
        activeTab = tab
    }

}

/// event card
extension ProfileViewModel: EventCardProtocol {

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
