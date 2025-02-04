import Foundation

public enum PlaceHandler {
    static func handlePlace(_ place: PlaceModel?) -> String {
        var placeDescription = CreateEventCommonItem.emptyPlaceText

        if let place {
            placeDescription = ""

            let ocean = place.placemark.ocean ?? ""
            let inlandWater = place.placemark.inlandWater ?? ""
            let country = place.placemark.country ?? ""
            let locality = place.placemark.locality ?? ""
            let thoroughfare = place.placemark.thoroughfare ?? ""
            let subThoroughfare = place.placemark.subThoroughfare ?? ""

            if ocean != "" {
                placeDescription += "\(ocean)\n"
            } else if inlandWater != "" {
                placeDescription += "\(inlandWater)\n"
            } else {
                placeDescription += country == "" ? "" : "\(country)\n"
                placeDescription += locality == "" ? "" : "\(locality)\n"
                placeDescription += thoroughfare == "" ? "" : "\(thoroughfare)\n"
                placeDescription += subThoroughfare == "" ? "" : "\(subThoroughfare)\n"
            }

            placeDescription += "\n"

            let latitude = String(format: "%.4f", place.coordinate.latitude)
            let longitude = String(format: "%.4f", place.coordinate.longitude)
            placeDescription += "Широта: \(latitude)\nДолгота: \(longitude)"
        }

        return placeDescription
    }
}
