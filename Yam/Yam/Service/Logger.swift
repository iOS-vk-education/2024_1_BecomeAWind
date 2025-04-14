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

// MARK: - Auth

extension Logger {

    enum Auth {

        static func userCreated() {
            print("User created")
        }

        static func userAddedToDatabase() {
            print("User added to database")
        }

        static func userNotAddedToDatabase(error: Error) {
            print("User not added to database, error description = \(error.localizedDescription)")
        }

        static func userNotCreated(error: Error) {
            print("User not created, error description = \(error.localizedDescription)")
        }

        static func authSuccess() {
            print("Authorization success")
        }

        static func authFail(error: Error) {
            print("Authorization fail, error description = \(error.localizedDescription)")
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
