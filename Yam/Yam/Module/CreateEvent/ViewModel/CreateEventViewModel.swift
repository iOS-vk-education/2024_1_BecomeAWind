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
}

// for CreateEventPlaceView
extension CreateEventViewModel {
    func getPlacemark(for coordinate: CLLocationCoordinate2D,
                             completion: @escaping (CLPlacemark?) -> Void) {
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

    func handlePlaceObject(_ place: PlaceModel) {
        self.place = place
        placeDescription = PlaceHandler.handlePlace(place)
    }
}
