import UIKit
import _MapKit_SwiftUI
import MapKit

class CitySearchViewModel: NSObject, ObservableObject, MKLocalSearchCompleterDelegate {
    @Published var searchQuery: String = ""
    @Published var searchResults: [CityResult] = []
    @Published var position: MapCameraPosition = .userLocation(fallback: .automatic)
    
    private var searchCompleter: MKLocalSearchCompleter!
    
    override init() {
        super.init()
        
        searchCompleter = MKLocalSearchCompleter()
        searchCompleter.delegate = self
        searchCompleter.resultTypes = .address
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        getCityList(results: completer.results) { cityResults in
            DispatchQueue.main.async {
                self.searchResults = cityResults
            }
        }
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) { }
    
    func performSearch() {
        searchCompleter.queryFragment = searchQuery
    }
    
    struct CityResult: Hashable {
        var city: String
        var country: String
        var latitude: Double
        var longitude: Double
    }
    
    private func getCityList(results: [MKLocalSearchCompletion], completion: @escaping ([CityResult]) -> Void) {
        var searchResults: [CityResult] = []
        let dispatchGroup = DispatchGroup()
        
        for result in results {
            dispatchGroup.enter()
            
            let request = MKLocalSearch.Request(completion: result)
            let search = MKLocalSearch(request: request)
            
            search.start { (response, error) in
                defer {
                    dispatchGroup.leave()
                }
                
                guard let response = response else { return }
                
                for item in response.mapItems {
                    if let location = item.placemark.location {
                        
                        let city = item.placemark.locality ?? ""
                        var country = item.placemark.country ?? ""
                        if country.isEmpty {
                            country = item.placemark.countryCode ?? ""
                        }
                        
                        if !city.isEmpty {
                            let cityResult = CityResult(city: city, country: country, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                            searchResults.append(cityResult)
                        }
                    }
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(searchResults)
        }
    }
}

//extension CitySearchViewModel {
//    func centerMapOnEvent() {
//        let coordinate = event.place.location.coordinate
//        withAnimation(.easeInOut(duration: 0.5)) {
//            position = .region(MKCoordinateRegion(
//                center: CLLocationCoordinate2D(
//                    latitude: coordinate.latitude,
//                    longitude: coordinate.longitude
//                ),
//                span: MKCoordinateSpan(
//                    latitudeDelta: 0.05,
//                    longitudeDelta: 0.05
//                )
//            )
//            )
//        }
//    }
//}
