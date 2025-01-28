import Foundation
import SwiftUI

final class CreateEventModel: ObservableObject {
    @ObservedObject private var tempDatabase = TempDatabase.shared

    func createEvent(_ event: Event) -> Bool {
        var hasEventCreated = true

        // validate data
        if !textHasLettersOrDigits(event.description.title) ||
            !textHasLettersOrDigits(String(event.organization.seats)) ||
            !textHasLettersOrDigits(event.organization.link) {
            hasEventCreated = false
        }

        if event.organization.place == nil {
            hasEventCreated = false
        }

        // create? event
        if hasEventCreated {
            tempDatabase.events.append(event)
        }

        return hasEventCreated
    }

}

// validate data
extension CreateEventModel {
    private func textHasLettersOrDigits(_ text: String) -> Bool {
        let pattern = ".*[\\p{L}\\d].*" // any letters / digits
        let regex = try? NSRegularExpression(pattern: pattern)
        let range = NSRange(text.startIndex..<text.endIndex, in: text)
        return regex?.firstMatch(in: text, range: range) != nil
    }

//    private func formateDateStringFrom(_ date: Date) -> String {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "dd-MM-yyyy HH:mm"
//        let result = formatter.dateF
//    }
}
