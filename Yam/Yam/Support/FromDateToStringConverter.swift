import Foundation

public enum FromDateToStringConverter {
    static func getDateString(from date: DateModel) -> String {
        var result = ""
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy\nHH:mm\n"

        result = formatter.string(from: date.date)
        result += date.timeZone.localizedName(for: .standard, locale: Locales.ru) ?? ""

        return result
    }
}
