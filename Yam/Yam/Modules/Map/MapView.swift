import SwiftUI
import MapKit
import ClusterMapSwiftUI

struct MapView: View {

    @StateObject private var viewModel = MapViewModel()

    var body: some View {
        Map(position: $viewModel.position) {
            UserAnnotation()

            ForEach(viewModel.annotations) { annotation in
                Marker(
                    "\(annotation.coordinate.latitude) \(annotation.coordinate.longitude)",
                    systemImage: "mappin",
                    coordinate: annotation.coordinate
                )
                .annotationTitles(.hidden)
            }
            ForEach(viewModel.clusters) { annotation in
                Marker(
                    "\(annotation.count)",
                    systemImage: "square.3.layers.3d",
                    coordinate: annotation.coordinate
                )
            }

        }
        .colorScheme(.light)
        .tint(Color.purple)
        .mapControls {
            MapUserLocationButton()
        }
        .readSize(onChange: { newValue in
            viewModel.mapSize = newValue
        })
        .onMapCameraChange(frequency: .onEnd) { context in
            viewModel.region = context.region
            Task.detached {
                await viewModel.reloadAnnotations()
            }
        }
    }

}
