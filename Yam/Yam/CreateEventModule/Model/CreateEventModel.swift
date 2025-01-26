import Foundation
import SwiftUI

final class CreateEventModel: ObservableObject {
    @ObservedObject private var tempDatabase = TempDatabase.shared

    func handlePlace(_ place: PlaceModel) -> String {
        var result = ""

        let ocean = place.placemark.ocean ?? ""
        let inlandWater = place.placemark.inlandWater ?? ""
        let country = place.placemark.country ?? ""
        let locality = place.placemark.locality ?? ""
        let thoroughfare = place.placemark.thoroughfare ?? ""
        let subThoroughfare = place.placemark.subThoroughfare ?? ""

        if ocean != "" {
            result += "\(ocean)\n"
        } else if inlandWater != "" {
            result += "\(inlandWater)\n"
        } else {
            result += country == "" ? "" : "\(country)\n"
            result += locality == "" ? "" : "\(locality)\n"
            result += thoroughfare == "" ? "" : "\(thoroughfare)\n"
            result += subThoroughfare == "" ? "" : "\(subThoroughfare)\n"
        }

        return result
    }

    func createEvent(_ event: Event) -> Bool {
        var hasEventCreated = true

        // validate data
        if !textHasLettersOrDigits(event.description.title) ||
            !textHasLettersOrDigits(String(event.organization.seats)) ||
            !textHasLettersOrDigits(event.organization.link) {
            hasEventCreated = false
        }

        if event.organization.place == "Выберите место проведения мероприятия" {
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
