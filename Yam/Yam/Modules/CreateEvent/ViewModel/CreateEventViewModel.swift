import _PhotosUI_SwiftUI
import SwiftUI
import MapKit

final class CreateEventViewModel: NSObject, ObservableObject, MKMapViewDelegate {

    @ObservedObject private var model: CreateEventModel // delme

    /// image picker
    @Published var image = UIImage(named: "default_event_image") ?? UIImage(systemName: "photo.artframe")!
    @Published var photosPickerItem: PhotosPickerItem?

    /// text fields
    @Published var eventTitle = ""
    @Published var seats = "1"
    @Published var link = ""

    /// date picker
    @Published var date = Date()

    /// place picker
    @Published var isActiveCreateEventPlace = false
    @Published var centerCoordinate = CLLocationCoordinate2D()
    @Published var place: PlaceModel?

    /// create event button
    @Published var emptyEventAlertIsActive = false

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

/// image picker
extension CreateEventViewModel {
    func setImage() {
        Task {
            if let photosPickerItem,
               let data = try? await photosPickerItem.loadTransferable(type: Data.self) {
                if let image = UIImage(data: data) {
                    self.image = image
                }
            }
            photosPickerItem = nil
        }
    }
}

/// place picker
extension CreateEventViewModel {

    // conformance to MKMapViewDelegate
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        DispatchQueue.main.async {
            self.centerCoordinate = mapView.centerCoordinate
        }
    }

    func toggleCreateEventPlace() {
        isActiveCreateEventPlace.toggle()
    }

    func getPlacemark(completion: @escaping (Bool) -> Void) {
        let coordinate = centerCoordinate

        // make location from latitude and longitude
        let location = CLLocation(
            latitude: coordinate.latitude,
            longitude: coordinate.longitude
        )
        let geocoder = CLGeocoder()

        // get placemark from location
        geocoder.reverseGeocodeLocation(location, preferredLocale: Locales.ru) { placemarks, error in
            if error == nil {
                let firstPlacemark = placemarks?[0]
                if let placemark = firstPlacemark {
                    let place = PlaceModel(
                        placemark: placemark,
                        coordinate: coordinate
                    )
                    self.handlePlaceObject(place)

                    completion(true)
                } else {
                    // error during geocoding
                    completion(false)
                }
            }
        }
    }

    func handlePlaceObject(_ place: PlaceModel) {
        self.place = place
    }

    func getPlaceDescription() -> String {
        PlaceHandler.handlePlace(place)
    }

}

/// text field
extension CreateEventViewModel {

    func limitTextField(_ upper: Int, text: Binding<String>) {
        if text.wrappedValue.count > upper {
            text.wrappedValue = String(text.wrappedValue.prefix(upper))
        }
    }

    func filterSeats(_ newValue: String) {
        seats = newValue.filter { seats.first != "0" && $0.isNumber }
    }

}
