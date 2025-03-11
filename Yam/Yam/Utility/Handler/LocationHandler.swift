import CoreLocation

final class LocationHandler {

    static func getPlacemark(
        from location: CLLocation,
        completion: @escaping (CLPlacemark?) -> Void
    ) {
        let geocoder = CLGeocoder()

        geocoder.reverseGeocodeLocation(
            location,
            preferredLocale: Locales.ru
        ) { placemarks, error in
            if error == nil {
                let firstPlacemark = placemarks?[0]
                if let placemark = firstPlacemark {
                    completion(placemark)
                } else {
                    completion(nil)
                }
            }
        }
    }

    static func parsePlacemark(_ placemark: CLPlacemark) -> String {
        var description = ""
        let ocean = placemark.ocean ?? ""
        let inlandWater = placemark.inlandWater ?? ""
        let country = placemark.country ?? ""
        let locality = placemark.locality ?? ""
        let thoroughfare = placemark.thoroughfare ?? ""
        let subThoroughfare = placemark.subThoroughfare ?? ""

        if ocean != "" {
            description += "\(ocean)\n"
        } else if inlandWater != "" {
            description += "\(inlandWater)\n"
        } else {
            description += country == "" ? "" : "\(country)\n"
            description += locality == "" ? "" : "\(locality)\n"
            description += thoroughfare == "" ? "" : "\(thoroughfare)\n"
            description += subThoroughfare == "" ? "" : "\(subThoroughfare)\n"
        }

        description += "\n"

        let latitude = String(format: "%.4f", placemark.location?.coordinate.latitude ?? 0.0)
        let longitude = String(format: "%.4f", placemark.location?.coordinate.longitude ?? 0.0)
        description += "Широта: \(latitude)\nДолгота: \(longitude)"

        return description
    }

    private func printPlacemarkInfo(placemark: CLPlacemark) {
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
