import CoreLocation

struct Logger {}

// MARK: - Core

extension Logger {

    enum Core {

        static func firebaseConfigured() {
            print("Firebase configured")
        }

    }

}

extension Logger {

    enum Database {

        static func databaseInit() {
            print("TempDatabase initialized")
        }

    }

}

extension Logger {

    static func printPlacemarkInfo(placemark: CLPlacemark) {
        print("AdministrativeArea = \(String(describing: placemark.administrativeArea))")
        print("Country = \(String(describing: placemark.country))")
        print("inlandWater = \(String(describing: placemark.inlandWater))")
        print("locality = \(String(describing: placemark.locality))")
        print("ocean = \(String(describing: placemark.ocean))")
        print("subAdministrativeArea = \(String(describing: placemark.subAdministrativeArea))")
        print("subLocality = \(String(describing: placemark.subLocality))")
        print("subThoroughfare = \(String(describing: placemark.subThoroughfare))")
        print("thoroughfare = \(String(describing: placemark.thoroughfare))")
        print()
    }

}
