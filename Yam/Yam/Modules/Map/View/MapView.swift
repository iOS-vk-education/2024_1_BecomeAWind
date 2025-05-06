import SwiftUI
import MapKit
import ClusterMapSwiftUI

struct MapView: View {

    @StateObject private var viewModel = MapViewModel()

    var body: some View {
        Map(position: $viewModel.position) {
            UserAnnotation()

            ForEach(viewModel.annotations) { annotation in
                Annotation("", coordinate: annotation.coordinate) {
                    MapEventAnnotation(imagePath: annotation.imagePath)
                }
            }
            
            ForEach(viewModel.clusters) { annotation in
                Annotation("", coordinate: annotation.coordinate) {
                    MapClusterView(count: annotation.count)
                }
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
