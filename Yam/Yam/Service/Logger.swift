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

    static func success() {
        print("... success ...\n")
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
            print("Error getting document, error desc = \(error.localizedDescription)\n")
        }

        static func loadImageFail(by path: String, with error: Error) {
            print("Load image fail by path = \(path), error desc = \(error.localizedDescription)")
        }

        static func initialMyEventsLoadFail(_ error: Error) {
            print("Initial myEvents load fail, error desc = \(error.localizedDescription)")
        }

        static func nextPackMyEventsLoadFail(_ error: Error) {
            print("Next pack myEvents load fail, error desc = \(error.localizedDescription)")
        }

    }

    enum MyEvents {

        static func eventRemovedFromTable(eventID: String) {
            print("Event with ID = \(eventID) removed from table\n")
        }

        static func eventNotRemovedFromTable(eventID: String) {
            print("Event with ID = \(eventID) not removed from table\n")
        }

    }

}

// MARK: - BuildEvent

extension Logger {

    enum BuildEvent {

        static func notJpegData() {
            print("Data is not JPEG\n")
        }

        static func imageUploadSuccess(with url: String) {
            print("Image upload success, imageUrl = \(url)\n")
        }

        static func imageUploadFail() {
            print("Image upload fail\n")
        }

        static func eventCreateSuccess(id: String) {
            print("Event create success, id = \(id)\n")
        }

        static func eventCreateFail(_ error: Error?) {
            print("Event create fail ", terminator: "")
            if let error {
                print("error desc = \(error.localizedDescription)\n")
            }
        }

        static func eventEditSuccess() {
            print("Event edit success\n")
        }

        static func eventEditFail(_ error: Error?) {
            print("Event edit fail ", terminator: "")
            if let error {
                print("error desc = \(error.localizedDescription)\n")
            }
        }

        static func eventDeleteSuccess() {
            print("Event delete success\n")
        }

        static func eventDeleteFail(_ error: Error?) {
            print("Event delete fail, ", terminator: "")
            if let error {
                print("error desc = \(error.localizedDescription)\n")
            }
        }

    }

}

// MARK: - Feed

extension Logger {

    enum Feed {

        static func initialFeedLoadFail(_ error: Error) {
            print("Initial feed load fail, error desc = \(error.localizedDescription)\n")
        }

        static func nextPackFeedLoadFail(_ error: Error) {
            print("Next pack feed load fail, error desc = \(error.localizedDescription)\n")
        }

        static func getEventsIDsFail(_ error: Error) {
            print("Get eventsIDsFail, error desc = \(error.localizedDescription)\n")
        }

        static func subscribeToTheEventSuccess() {
            print("Subscribe to the event success\n")
        }

        static func subscribeToTheEventFail(_ error: Error) {
            print("Subscribe to the event fail, error desc = \(error.localizedDescription)\n")
        }

        static func unsubscribeToTheEventSuccess() {
            print("Unsubscribe to the event success\n")
        }

        static func unsubscribeToTheEventFail(_ error: Error) {
            print("Unsubscribe to the event fail, error desc = \(error.localizedDescription)\n")
        }

        static func eventUpdated() {
            print("Event updated\n")
        }

        static func eventNotUpdated(_ error: Error? = nil) {
            print("Event not updated,", terminator: " ")
            if let error {
                print("error desc = \(error.localizedDescription)\n")
            }
        }

    }

}

// MARK: - Map

extension Logger {

    enum Map {

        static func fetchMatchingEventsFail(_ error: Error) {
            print("Failed to fetch matching events in map module, error desc = \(error.localizedDescription)")
        }

        static func loadEventsFail(_ error: Error) {
            print("Load events fail, error desc = \(error.localizedDescription)")
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
