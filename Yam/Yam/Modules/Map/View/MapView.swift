import SwiftUI
import MapKit
import UIKit

struct MapView: View {
    @StateObject private var vm = MapSearchViewModel()

    var body: some View {
        Map(position: $vm.cameraPosition) {
            if let place = vm.selectedPlace {
                Marker("", coordinate: place.mapItem.placemark.coordinate)
                    .tint(.red)
            }
        }
        .ignoresSafeArea()
        .overlay(alignment: .top) {
            VStack(spacing: 0) {
                TextField("Введите адрес", text: $vm.searchText)
                    .padding(12)
                    .background(.regularMaterial)
                    .cornerRadius(12)
                    .padding()
                    .onChange(of: vm.searchText) { newValue in
                        vm.updateSearch(query: newValue)
                    }

                if !vm.completions.isEmpty {
                    let maxHeight = min(CGFloat(vm.completions.count) * 56,
                                        UIScreen.main.bounds.height * 0.6)
                    
                    List {
                        ForEach(vm.completions) { completion in
                            Button {
                                vm.resolveCompletion(completion) {
                                    vm.clearSuggestions()
                                    hideKeyboard()
                                }
                            
                                vm.searchText = "\(completion.title), \(completion.subtitle)"
                            } label: {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(completion.title).font(.headline)
                                    Text(completion.subtitle)
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                                .padding(.vertical, 4)
                            }
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .frame(maxHeight: maxHeight, alignment: .top)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal)
                }
            }
        }
        .animation(.default, value: vm.completions)
    }
}

@inline(__always)
private func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}


//import SwiftUI
//import _MapKit_SwiftUI
//import MapKit
//
//struct MapView: View {
//    @StateObject private var viewModel = MapViewModel()
//    @StateObject private var mapAPI = MapAPI()
//
//    @State private var searchQuery: String = ""
//
//    var body: some View {
//        VStack {
//            TextField("Enter the location", text: $searchQuery)
//                .textFieldStyle(.roundedBorder)
//                .padding(.horizontal)
//            
//            Button("Find address") {
//                mapAPI.getLocation(address: searchQuery, delta: 0.01)
//            }
//            
//            Map(coordinateRegion: $mapAPI.region, annotationItems: mapAPI.locations) { location in
//                MapMarker(coordinate: location.coordinate, tint: .blue)
//            }
//            .ignoresSafeArea()
//            .colorScheme(.light)
//            .tint(Color.purple)
//            .mapControls {
//                MapUserLocationButton()
//            }
//        }
//    }
//}
//
//#Preview {
//    MapView()
//}
