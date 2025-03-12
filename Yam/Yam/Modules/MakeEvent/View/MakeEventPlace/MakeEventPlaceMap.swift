import SwiftUI
import MapKit

struct MakeEventPlaceMap {
    @ObservedObject var viewModel: MakeEventViewModel
}

extension MakeEventPlaceMap: UIViewRepresentable {
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

    func makeCoordinator() -> MakeEventViewModel {
        viewModel
    }
}
