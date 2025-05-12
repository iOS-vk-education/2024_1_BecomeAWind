import SwiftUI
import UIKit
import MapKit

final class MapSearchViewModel: NSObject, ObservableObject, MKLocalSearchCompleterDelegate {
    @Published var searchText = ""
    @Published var completions: [MKLocalSearchCompletion] = []
    @Published var selectedPlace: SearchPlace?
    @Published var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 55.7558, longitude: 37.6173),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    )

    private let completer = MKLocalSearchCompleter()

    override init() {
        super.init()
        completer.resultTypes = .address
        completer.delegate = self
    }

    func updateSearch(query: String) {
        completer.queryFragment = query
    }

    func clearSuggestions() {
        completions.removeAll()
        completer.queryFragment = ""
    }

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        completions = completer.results
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print("SearchCompleter error: \(error.localizedDescription)")
    }

    func resolveCompletion(_ completion: MKLocalSearchCompletion, completionHandler: @escaping () -> Void) {
        let request = MKLocalSearch.Request(completion: completion)
        MKLocalSearch(request: request).start { [weak self] response, _ in
            guard let self, let mapItem = response?.mapItems.first else { return }
            DispatchQueue.main.async {
                self.selectedPlace = SearchPlace(mapItem: mapItem)
                self.cameraPosition = .region(
                    MKCoordinateRegion(
                        center: mapItem.placemark.coordinate,
                        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                    )
                )
                completionHandler()
            }
        }
    }
}

extension MKLocalSearchCompletion: Identifiable {
    public var id: String { "\(title)|\(subtitle)" }
}

