import CoreLocation

final class LocationHandler {

    static func getPlacemarkDescription(from location: CLLocation) async -> String {
        let geocoder = CLGeocoder()
        var placemarks = [CLPlacemark]()

        do {
            placemarks = try await geocoder.reverseGeocodeLocation(location, preferredLocale: Locale(identifier: "ru_RU"))
        } catch {
            Logger.LocationHandler.getPlacemarkFail(with: error)
        }

        return LocationHandler.parsePlacemark(placemarks.first)
    }

    static private func parsePlacemark(_ placemark: CLPlacemark?) -> String {
        guard let placemark else { return BuildEventConst.placeFailText }

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
