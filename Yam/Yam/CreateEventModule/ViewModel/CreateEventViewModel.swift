import SwiftUI
import MapKit

final class CreateEventViewModel: ObservableObject {
    @ObservedObject private var model: CreateEventModel
    @Published var emptyEventAlertIsActive = false
    @Published var placeDescription: String = "Выберите место проведения мероприятия"

    init(model: CreateEventModel) {
        self.model = model
    }

    func handlePlace(_ place: PlaceModel) {
        placeDescription.removeAll()
        placeDescription = model.handlePlace(place)
        let latitude = String(format: "%.4f", place.coordinate.latitude)
        let longitude = String(format: "%.4f", place.coordinate.longitude)
        placeDescription += "Широта: \(latitude)\nДолгота: \(longitude)"
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
