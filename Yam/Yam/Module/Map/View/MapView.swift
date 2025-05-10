import SwiftUI
import MapKit
import ClusterMapSwiftUI

struct MapView: View {

    @StateObject private var viewModel = MapViewModel()

    var body: some View {
        ZStack {
            Map(position: $viewModel.position) {
                UserAnnotation()

                ForEach(viewModel.annotations) { annotation in
                    Annotation("", coordinate: annotation.coordinate) {
                        MapEventAnnotation(imagePath: annotation.event.imagePath) {
                            Task {
                                await viewModel.showEventsAccordion(eventPack: [annotation.event])
                            }
                        }
                    }
                }

                ForEach(viewModel.clusters) { annotation in
                    Annotation("", coordinate: annotation.coordinate) {
                        MapClusterView(count: annotation.eventPack.count) {
                            Task {
                                await viewModel.showEventsAccordion(eventPack: annotation.eventPack)
                            }
                        }
                    }
                }

            }
            .colorScheme(.light)
            .tint(Color.purple)
            .readSize(onChange: { newValue in
                viewModel.mapSize = newValue
            })
            .onMapCameraChange(frequency: .onEnd) { context in
                viewModel.region = context.region
                Task.detached {
                    await viewModel.reloadAnnotations()
                }
            }
            .sheet(isPresented: $viewModel.isActiveEventsAccordion) {
                viewModel.configureEventsAccordionView(eventPack: viewModel.currentEventPack)
            }


            VStack {
                Spacer()

                LocationButton {
                    viewModel.centerMapOnUserLocation()
                }

                TabBarSpace()
            }
        }
    }

}
