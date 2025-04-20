import CoreLocation
import FirebaseAuth

struct Logger {}

// MARK: - Core

extension Logger {

    static func firebaseConfigured() {
        print("Firebase configured\n")
    }

    static func ping() {
        print("... ping ...")
    }
}

// MARK: - Auth

extension Logger {

    enum Auth {

        static func userCreated() {
            print("User created\n")
        }

        static func userNotCreated(error: Error) {
            print("User not created, error description = \(error.localizedDescription)\n")
        }

        static func userAddedToDatabase() {
            print("User added to database\n")
        }

        static func userNotAddedToDatabase(error: Error) {
            print("User not added to database, error description = \(error.localizedDescription)\n")
        }

        static func authSuccess() {
            print("Authorization success\n")
        }

        static func authFail(error: Error) {
            print("Authorization fail, error description = \(error.localizedDescription)\n")
        }

        static func signOutSuccess() {
            print("Sing out success\n")
        }

        static func signOutFail(error: Error) {
            print("Sign out fail, error description = \(error.localizedDescription)\n")
        }

        static func printCurrentUserSession(_ user: User?) {
            if let user {
                print("--- USER DATA ---")
                print("uid = \(user.uid)")
                print("email = \(user.email)")
                print("--- USER DATA ---")
            } else {
                print("--- USER DATA ---")
                print("nil")
                print("--- USER DATA ---")
            }
            print()
        }

    }

}

extension Logger {

    enum Database {

        static func imageServiceInited() {
            print("ImageService inited\n")
        }

        static func databaseInit() {
            print("TempDatabase initialized\n")
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
