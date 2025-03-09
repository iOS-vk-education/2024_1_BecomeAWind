import Foundation
import CoreLocation

enum PlaceHandler {
    static func handlePlace(_ place: PlaceModel?) -> String {
        var placeDescription = CreateEventConst.emptyPlaceText

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

    static func printPlacemarkInfo(placemark: CLPlacemark) {
        print("AdministrativeArea = \(String(describing: placemark.administrativeArea))")
        print("Country = \(String(describing: placemark.country))")
        print("inlandWater = \(String(describing: placemark.inlandWater))")
        print("locality = \(String(describing: placemark.locality))")
        print("ocean = \(String(describing: placemark.ocean))")
        print("subAdministrativeArea = \(String(describing: placemark.subAdministrativeArea))")
        print("subLocality = \(String(describing: placemark.subLocality))")
        print("subThoroughfare = \(String(describing: placemark.subThoroughfare))")
        print("thoroughfare = \(String(describing: placemark.thoroughfare))")
        print()
    }

}
