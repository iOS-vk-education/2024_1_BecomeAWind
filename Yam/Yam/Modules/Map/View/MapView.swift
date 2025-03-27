import SwiftUI
import _MapKit_SwiftUI

struct MapView: View {

    @StateObject private var viewModel = MapViewModel()

    var body: some View {
        Map(position: $viewModel.position) {
            UserAnnotation()
        }
        .colorScheme(.light)
        .tint(Color.purple)
        .mapControls {
            MapUserLocationButton()
        }
    }
    
}

#Preview {
    MapView()
}
