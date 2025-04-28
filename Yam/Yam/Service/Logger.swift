import CoreLocation
import FirebaseAuth

struct Logger {}

// MARK: - Core

extension Logger {

    static func firebaseConfigured() {
        print("Firebase configured\n")
    }

    static func printErrorDescription(_ error: Error) {
        print("Error desc = \(error.localizedDescription)\n")
    }

    static func ping() {
        print("... ping ...\n")
    }
}

// MARK: - Auth

extension Logger {

    enum Auth {

        static func userCreated() {
            print("User created\n")
        }

        static func userNotCreated(error: Error) {
            print("User not created, error desc = \(error.localizedDescription)\n")
        }

        static func userAddedToDatabase() {
            print("User added to database\n")
        }

        static func userNotAddedToDatabase(error: Error) {
            print("User not added to database, error desc = \(error.localizedDescription)\n")
        }

        static func authSuccess() {
            print("Authorization success\n")
        }

        static func authFail(error: Error) {
            print("Authorization fail, error desc = \(error.localizedDescription)\n")
        }

        static func signOutSuccess() {
            print("Sing out success\n")
        }

        static func signOutFail(error: Error) {
            print("Sign out fail, error desc = \(error.localizedDescription)\n")
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

// MARK: - Events

extension Logger {

    enum Events {

        static func docDoesntExist() {
            print("Document doesn't exist\n")
        }

        static func errorGettingDocument(_ error: Error) {
            print("Error getting document desc = \(error.localizedDescription)\n")
        }

        static func loadImageFail(by path: String, with error: Error) {
            print("Load image fail by path = \(path), error desc = \(error.localizedDescription)")
        }

    }

}

// MARK: - BuildEvent

extension Logger {

    enum BuildEvent {

        static func notJpegData() {
            print("Data is not JPEG")
        }

        static func imageUploadSuccess(with url: String) {
            print("Image upload success, imageUrl = \(url)")
        }

        static func imageUploadFail() {
            print("Image upload fail")
        }

        static func eventCreateSuccess() {
            print("Event create success")
        }

        static func eventCreateFail() {
            print("Event create fail")
        }

        static func eventEditSuccess() {
            print("Event edit success")
        }

        static func eventEditFail(_ error: Error) {
            print("Event edit fail, error desc = \(error)")
        }

        static func eventDeleteSuccess() {
            print("Event delete success")
        }

        static func eventDeleteFail(_ error: Error) {
            print("Event delete fail, error desc = \(error)")
        }

    }

}

// MARK: - Database

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

// MARK: - Location Handler

extension Logger {

    enum LocationHandler {

        static func getPlacemarkFail(with error: Error) {
            print("Get placemark fail, error desc = \(error.localizedDescription)")
        }

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

}
