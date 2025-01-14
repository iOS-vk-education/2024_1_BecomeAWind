import SwiftUI
import MapKit

struct ChooseEventPlaceMapViewModel {
    @Binding var centerCoordinate: CLLocationCoordinate2D

    final class Coordinator: NSObject, MKMapViewDelegate {
        var parent: ChooseEventPlaceMapViewModel

        init(parent: ChooseEventPlaceMapViewModel) {
            self.parent = parent
        }

        /* Because the map may call this method many times during the scrolling of the map ...
         https://developer.apple.com/documentation/mapkit/mkmapviewdelegate/mapviewdidchangevisibleregion(_:)
         */
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            DispatchQueue.main.async {
                self.parent.centerCoordinate = mapView.centerCoordinate
            }
        }
    }

    static func getPlacemark(for coordinate: CLLocationCoordinate2D,
                             completion: @escaping (CLPlacemark?)
                             -> Void ) {

        // Make location from latitude and longitude
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let geocoder = CLGeocoder()

        // Get placemark from location
        geocoder.reverseGeocodeLocation(location, preferredLocale: Locale(identifier: "en_US")) { placemarks, error in
            if error == nil {
                let firstPlacemark = placemarks?[0]
                completion(firstPlacemark)
            } else {
                // Error during geocoding
                completion(nil)
            }
        }
    }
}

extension ChooseEventPlaceMapViewModel: UIViewRepresentable {
    /*
     SwiftUI calls this method before calling the makeUIViewController(context:) method.
     https://developer.apple.com/documentation/swiftui/uiviewcontrollerrepresentable/makecoordinator()-9vwm8
     */
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    /*
     The system calls this method only once, when it creates your view for the first time.
     https://developer.apple.com/documentation/swiftui/uiviewrepresentable/makeuiview(context:)
     */
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {}
}

final class CreateEventViewModel: ObservableObject {
    @ObservedObject var model: CreateEventModel
    @Published var placeDescription = "Выберите место проведения события"
    @Published var emptyEventAlertIsActive = false

    init(model: CreateEventModel) {
        self.model = model
    }

    func handlePlace(_ place: Place) {
        let ocean = place.placemark.ocean ?? ""
        let inlandWater = place.placemark.inlandWater ?? ""
        let country = place.placemark.country ?? ""
        let locality = place.placemark.locality ?? ""
        let thoroughfare = place.placemark.thoroughfare ?? ""
        let subThoroughfare = place.placemark.subThoroughfare ?? ""

        placeDescription.removeAll()

        if ocean != "" {
            placeDescription += "\(ocean)\n"
        } else if inlandWater != "" {
            placeDescription += "\(inlandWater)\n"
        } else {
            placeDescription += country == "" ? "" : "\(country)\n"
            placeDescription += locality == "" ? "" : "\(locality)\n"
            placeDescription += thoroughfare == "" ? "" : "\(thoroughfare)\n"
            placeDescription += subThoroughfare == "" ? "" : "\(subThoroughfare)\n"
        }

        placeDescription += "Latitude | \(place.coordinate.latitude)\nLongitude | \(place.coordinate.longitude)"
    }

    func createEvent(_ event: Event) -> Bool {
//        if event.title == "" ||
//            event.description == "" ||
//            event.place == "" ||
//            event.seats == 0 ||
//            event.contact == "" {
//            emptyEventAlertIsActive.toggle()
//            return false
//        } else {
//            model.createEvent(event)
//            return true
//        }

        // mock event creation
        model.createEvent(Event(title: "Событие",
                                description: "Описание описание описание",
                                place: "Место",
                                seats: 20,
                                contact: "Контакт")
        )

        return true
    }


}

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



