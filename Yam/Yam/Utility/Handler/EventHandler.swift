import UIKit

final class EventHandler {

    static func openLink(_ link: String) -> Bool {
        guard let url = URL(string: link), UIApplication.shared.canOpenURL(url) else {
            return false
        }
        UIApplication.shared.open(url)
        return true
    }

    static func getSeatsString(from seats: Seats) -> String {
        "\(seats.busy) / \(seats.all)"
    }

    static func getDateString(from date: Date) -> String {
        DateHandler.getDateString(from: date)
    }

}
