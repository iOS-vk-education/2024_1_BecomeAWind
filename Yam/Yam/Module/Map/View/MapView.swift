import SwiftUI
import MapKit
import ClusterMapSwiftUI

struct MapView: View {

    @ObservedObject var viewModel: MapViewModel

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

            MapBottomButtons(viewModel: viewModel)
            
        }
        .fullScreenCover(isPresented: $viewModel.isActiveEvents) {
            viewModel.makeEventsView()
                .onDisappear {
                    Task {
                        await viewModel.loadEvents(at: viewModel.userLocation)
                    }
                }
        }
        .sheet(isPresented: $viewModel.isActiveEventsAccordion) {
            viewModel.makeEventsAccordionView(eventPack: viewModel.currentEventPack)
        }
        .sheet(isPresented: $viewModel.isActiveInfo) {
            viewModel.makeInfoView()
                .presentationDetents([.medium])
        }
    }

}

#Preview {
    MapView(viewModel: MapViewModel(navManager: NavigationManager()))
}


