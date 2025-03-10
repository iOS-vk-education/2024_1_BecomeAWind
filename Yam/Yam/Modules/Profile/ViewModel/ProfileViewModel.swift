import SwiftUI

final class ProfileViewModel: ObservableObject {

    @ObservedObject var db = TempDatabase.shared

    /// top tab bar
    @Published var isActiveCreateEvent = false
    @Published var activeTab: ProfileTab = .myEvents

    /// event card
    @Published var selectedEvent: Event?
    @Published var invalidLink = false
    @Published var isActiveEventLocation = false

}

/// top tab bar
extension ProfileViewModel {

    func changeActiveTabTo(_ tab: ProfileTab) {
        activeTab = tab
    }

}

/// event card
extension ProfileViewModel {

    func toggleCreateEvent() {
        isActiveCreateEvent.toggle()
    }

    func toggleEventLocation(for event: Event) {
        selectedEvent = event
        isActiveEventLocation.toggle()
    }

    func openLink(_ link: String) {
        if let url = URL(string: link) {
            UIApplication.shared.open(url)
        } else {
            invalidLink.toggle()
        }
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
