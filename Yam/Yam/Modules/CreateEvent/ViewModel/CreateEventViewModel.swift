import _PhotosUI_SwiftUI
import SwiftUI
import MapKit

final class CreateEventViewModel: ObservableObject {

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
    func toggleCreateEventPlace() {
        isActiveCreateEventPlace.toggle()
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
