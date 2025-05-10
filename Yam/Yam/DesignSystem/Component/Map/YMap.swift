import SwiftUI
import MapKit

struct YMap: UIViewRepresentable {

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.showsCompass = false
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {}

}
