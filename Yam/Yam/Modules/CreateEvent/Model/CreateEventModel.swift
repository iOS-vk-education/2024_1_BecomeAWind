import Foundation
import SwiftUI

final class CreateEventModel {

    private var tempDatabase = TempDatabase.shared

    func createEvent(_ event: Event) {
        tempDatabase.events.append(event)
        print(tempDatabase.events)
    }

}

// validate data
extension CreateEventModel {
    /*
    private func textHasLettersOrDigits(_ text: String) -> Bool {
        let pattern = ".*[\\p{L}\\d].*" // any letters / digits
        let regex = try? NSRegularExpression(pattern: pattern)
        let range = NSRange(text.startIndex..<text.endIndex, in: text)
        return regex?.firstMatch(in: text, range: range) != nil
    }
*/
//    private func formateDateStringFrom(_ date: Date) -> String {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "dd-MM-yyyy HH:mm"
//        let result = formatter.dateF
//    }
}
