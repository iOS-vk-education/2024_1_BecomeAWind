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
extension ProfileViewModel: YEventCardProtocol {

    func toggleEditEvent(for event: Event) {
        selectedEvent = event
        isActiveEditEvent.toggle()
    }

    func toggleEventLocation(for event: Event) {
        selectedEvent = event
        isActiveEventLocation.toggle()
    }

    func openLink(_ link: String) {
        if !EventHandler.openLink(link) {
            invalidLink.toggle()
        }
    }

    func handleSubscribeButton(for event: Event) {}

    func getSeatsString(from seats: Seats) -> String {
        EventHandler.getSeatsString(from: seats)
    }

    func getDateString(from date: Date) -> String {
        EventHandler.getDateString(from: date)
    }

}
