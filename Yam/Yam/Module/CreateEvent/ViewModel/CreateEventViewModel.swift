import SwiftUI
import MapKit

final class CreateEventViewModel: ObservableObject {
    @ObservedObject private var model: CreateEventModel
    @Published var emptyEventAlertIsActive = false
    @Published var placeDescription: String = CreateEventCommonItem.emptyPlaceText
    @Published var place: PlaceModel?

    init(model: CreateEventModel) {
        self.model = model
    }

    func createEvent(_ event: Event) -> Bool {
        if model.createEvent(event) {
            return true
        } else {
            emptyEventAlertIsActive.toggle()
            return false
        }
    }

    func getPlacemark(for coordinate: CLLocationCoordinate2D,
                             completion: @escaping (CLPlacemark?)
                             -> Void ) {
        // make location from latitude and longitude
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let geocoder = CLGeocoder()

        // get placemark from location
        geocoder.reverseGeocodeLocation(location, preferredLocale: Locale(identifier: "ru_RU")) { placemarks, error in
            if error == nil {
                let firstPlacemark = placemarks?[0]
                completion(firstPlacemark)
            } else {
                // error during geocoding
                completion(nil)
            }
        }
    }

    func handlePlace(_ place: PlaceModel) {
        placeDescription = PlaceHandler.handlePlace(place)
        self.place = place
    }
}

/*
extension CreateEventViewModel {
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
*/
