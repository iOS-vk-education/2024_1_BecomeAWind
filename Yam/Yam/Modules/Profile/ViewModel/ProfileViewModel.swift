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
extension ProfileViewModel {

    func toggleEditEvent(for event: Event) {
        selectedEvent = event
        isActiveEditEvent.toggle()
    }

    func toggleEventLocation(for event: Event) {
        selectedEvent = event
        isActiveEventLocation.toggle()
    }

    func openLink(_ link: String) {
        guard let url = URL(string: link), UIApplication.shared.canOpenURL(url) else {
            invalidLink.toggle()
            return
        }
        UIApplication.shared.open(url)
    }

    func getSeatsString(from seats: Seats) -> String {
        "\(seats.busy) / \(seats.all)"
    }

    func getDateString(from date: Date) -> String {
        var result = ""
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy\nHH:mm"

        result = formatter.string(from: date)

        return result
    }

}
