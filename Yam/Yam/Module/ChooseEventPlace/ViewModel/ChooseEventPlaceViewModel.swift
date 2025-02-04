import SwiftUI
import MapKit

struct ChooseEventPlaceViewModel {
    @Binding var centerCoordinate: CLLocationCoordinate2D

    final class Coordinator: NSObject, MKMapViewDelegate {
        var parent: ChooseEventPlaceViewModel

        init(parent: ChooseEventPlaceViewModel) {
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
        geocoder.reverseGeocodeLocation(location, preferredLocale: Locale(identifier: "ru_RU")) { placemarks, error in
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


extension ChooseEventPlaceViewModel: UIViewRepresentable {
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

