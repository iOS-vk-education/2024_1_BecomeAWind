//import Foundation
//import CoreLocation

//enum GeopointHandler {
//
//    static func getPlaceDescription(
//        _ coordinate: CLLocationCoordinate2D?,
//        completion: @escaping (String) -> Void
//    ) {
//        var placeDescription = CreateEventConst.emptyPlaceText
//
//        if let coordinate {
//            placeDescription = ""
//
//            getPlacemark(from: coordinate) { placemark in
//                if let placemark {
//                    let ocean = placemark.ocean ?? ""
//                    let inlandWater = placemark.inlandWater ?? ""
//                    let country = placemark.country ?? ""
//                    let locality = placemark.locality ?? ""
//                    let thoroughfare = placemark.thoroughfare ?? ""
//                    let subThoroughfare = placemark.subThoroughfare ?? ""
//
//                    if ocean != "" {
//                        placeDescription += "\(ocean)\n"
//                    } else if inlandWater != "" {
//                        placeDescription += "\(inlandWater)\n"
//                    } else {
//                        placeDescription += country == "" ? "" : "\(country)\n"
//                        placeDescription += locality == "" ? "" : "\(locality)\n"
//                        placeDescription += thoroughfare == "" ? "" : "\(thoroughfare)\n"
//                        placeDescription += subThoroughfare == "" ? "" : "\(subThoroughfare)\n"
//                    }
//
//                    placeDescription += "\n"
//
//                    let latitude = String(format: "%.4f", coordinate.latitude)
//                    let longitude = String(format: "%.4f", coordinate.longitude)
//                    placeDescription += "Широта: \(latitude)\nДолгота: \(longitude)"
//                }
//                completion(placeDescription)
//            }
//        }
//    }
//
//    private static func getPlacemark(
//        from coordinate: CLLocationCoordinate2D,
//        completion: @escaping (CLPlacemark?) -> Void
//    ) {
//        let location = CLLocation(
//            latitude: coordinate.latitude,
//            longitude: coordinate.longitude
//        )
//        let geocoder = CLGeocoder()
//
//        geocoder.reverseGeocodeLocation(
//            location,
//            preferredLocale: Locales.ru
//        ) { placemarks, error in
//            if error == nil {
//                let firstPlacemark = placemarks?[0]
//                if let placemark = firstPlacemark {
//                    completion(placemark)
//                } else {
//                    completion(nil)
//                }
//            }
//        }
//    }
//
//    private static func printPlacemarkInfo(placemark: CLPlacemark) {
//        print("AdministrativeArea = \(String(describing: placemark.administrativeArea))")
//        print("Country = \(String(describing: placemark.country))")
//        print("inlandWater = \(String(describing: placemark.inlandWater))")
//        print("locality = \(String(describing: placemark.locality))")
//        print("ocean = \(String(describing: placemark.ocean))")
//        print("subAdministrativeArea = \(String(describing: placemark.subAdministrativeArea))")
//        print("subLocality = \(String(describing: placemark.subLocality))")
//        print("subThoroughfare = \(String(describing: placemark.subThoroughfare))")
//        print("thoroughfare = \(String(describing: placemark.thoroughfare))")
//        print()
//    }
//
//}
