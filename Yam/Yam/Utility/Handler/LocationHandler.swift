import CoreLocation

final class LocationHandler {

    static func getPlacemark(from location: CLLocation, completion: @escaping (CLPlacemark?) -> Void) {
        let geocoder = CLGeocoder()

        geocoder.reverseGeocodeLocation(location, preferredLocale: Locale(identifier: "ru_RU")) { placemarks, error in
            if let error {
                completion(nil)
            }

            guard let placemarks, placemarks.count > 0 else {
                completion(nil)
                return
            }

            completion(placemarks[0])
        }
    }

    static func parsePlacemark(_ placemark: CLPlacemark) -> String {
        var description = [placemark.ocean, placemark.inlandWater, placemark.country, placemark.locality, placemark.thoroughfare, placemark.subThoroughfare]
            .compactMap { $0 }
            .filter { $0 != "" }
            .joined(separator: "\n")

        let latitude = String(format: "%.4f", placemark.location?.coordinate.latitude ?? 0.0)
        let longitude = String(format: "%.4f", placemark.location?.coordinate.longitude ?? 0.0)
        description += "\nШирота: \(latitude)\nДолгота: \(longitude)"

        return description
    }

}
