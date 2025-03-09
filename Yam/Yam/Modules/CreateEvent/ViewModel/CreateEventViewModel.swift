import _PhotosUI_SwiftUI
import SwiftUI
import MapKit

final class CreateEventViewModel: NSObject, ObservableObject, MKMapViewDelegate {

    private var model = CreateEventModel()

    /// image picker
    @Published private(set) var image = UIImage(named: "default_event_image") ?? UIImage(systemName: "photo.artframe")!
    @Published var photosPickerItem: PhotosPickerItem?

    /// text fields
    @Published var eventTitle = ""
    @Published var seats = "1"
    @Published var link = ""

    /// date picker
    @Published var date = Date()

    /// place picker
    @Published var isActiveCreateEventPlace = false
    @Published private(set) var centerCoordinate = CLLocationCoordinate2D()
    private var place: PlaceModel?

    /// create event
    @Published var eventCreationFailed = false

}

/// create event
extension CreateEventViewModel {

    func createEvent() -> Bool {
        var eventCreated = validateEventData()

        if eventCreated {
            let event = Event(
                image: image,
                title: eventTitle,
                seats: Int(seats) ?? 1,
                link: link,
                date: date
            )
            model.createEvent(event)
        }

        return eventCreated
    }

    func toggleEventCreationFailed() {
        eventCreationFailed.toggle()
    }

    private func validateEventData() -> Bool {
        var result = true

        if eventTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            link.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            getPlaceDescription() == CreateEventConst.emptyPlaceText {
            result = false
        }

        return result
    }

    private func printEventData() {
        print(eventTitle)
        print(seats)
        print(link)
        print(date)
        print(getPlaceDescription())
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
