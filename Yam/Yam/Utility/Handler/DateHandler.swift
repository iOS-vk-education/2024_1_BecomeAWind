import Foundation

final class DateHandler {

    static func getDateString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy\nHH:mm"

        return formatter.string(from: date)
    }

}
