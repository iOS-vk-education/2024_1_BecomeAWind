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
    @Published private(set) var centerCoordinate: CLLocationCoordinate2D?
    @Published var placeDescription = CreateEventConst.emptyPlaceText

    /// create event
    @Published var eventCreationFailed = false
    private var geopoint = CLLocation()

}

/// create event
extension CreateEventViewModel {

    func createEvent() -> Bool {
        let eventCreated = validateEventData()

        if eventCreated {
            let event = Event(
                image: image,
                title: eventTitle,
                seats: Int(seats) ?? 1,
                link: link,
                date: date,
                geopoint: geopoint
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
            placeDescription == CreateEventConst.emptyPlaceText {
            result = false
        }

        return result
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

}

/// location handler
extension CreateEventViewModel {

    func updatePlaceDescription(completion: @escaping (Bool) -> Void) {
        guard let coordinate = centerCoordinate else { return }
        placeDescription = ""

        getPlacemark(from: coordinate) { [weak self] placemark in
            if let placemark {
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

                let latitude = String(format: "%.4f", coordinate.latitude)
                let longitude = String(format: "%.4f", coordinate.longitude)
                description += "Широта: \(latitude)\nДолгота: \(longitude)"

                DispatchQueue.main.async {
                    self?.placeDescription = description
                    let geopoint = CLLocation(
                        latitude: coordinate.latitude,
                        longitude: coordinate.longitude
                    )
                    self?.geopoint = geopoint
                }
                completion(true)
            } else {
                completion(false)
            }
        }
    }

    private func getPlacemark(
        from coordinate: CLLocationCoordinate2D,
        completion: @escaping (CLPlacemark?) -> Void
    ) {
        let location = CLLocation(
            latitude: coordinate.latitude,
            longitude: coordinate.longitude
        )
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
