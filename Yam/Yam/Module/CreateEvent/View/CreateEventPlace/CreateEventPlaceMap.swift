import SwiftUI
import MapKit

struct CreateEventPlaceMap {
    @Binding var centerCoordinate: CLLocationCoordinate2D
}

extension CreateEventPlaceMap {
    final class Coordinator: NSObject, MKMapViewDelegate {
        var parent: CreateEventPlaceMap

        init(_ parent: CreateEventPlaceMap) {
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
}

extension CreateEventPlaceMap: UIViewRepresentable {
    /*
     The system calls this method only once, when it creates your view for the first time.
     https://developer.apple.com/documentation/swiftui/uiviewrepresentable/makeuiview(context:)
     */
    func makeUIView(context: Context) -> some UIView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
