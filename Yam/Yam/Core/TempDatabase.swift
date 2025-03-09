import SwiftUI
import MapKit
import Contacts

final class TempDatabase: ObservableObject {

    static let shared = TempDatabase()

    @Published var events: [Event] = []

    /*
    @Published var users: [UserModel] = [
        UserModel(login: "1", email: "1", password: "1"),
        UserModel(login: "2", email: "2", password: "2"),
        UserModel(login: "3", email: "3", password: "3")
    ]
     */
    
    private init() {
        print("TempDatabase initialized")
//        for _ in 0..<10 {
//            generateEvents()
//        }
    }

    func generateEvents() {
        let image = UIImage(named: "projectx")!
        let title = "Концерт Нейромонаха Феофана"
        let seats = 3000
        let link = "https://github.com/ilyansky/born2code"
        let date = Date()

        let coordinate = CLLocationCoordinate2D(latitude: 55.7558, longitude: 37.6173)

//        let place = PlaceModel(placemark: CLPlacemark, coordinate: <#T##CLLocationCoordinate2D#>)





//        let event = Event(description: eventDescription,
//                          organization: eventOrganization)
//        events.append(event)
    }

    @Published var location1 = CLLocation(latitude: 55.9558,
                                         longitude: 37.2173)
    @Published var location2 = CLLocation(latitude: 55.5568,
                                         longitude: 37.1143)
    @Published var location3 = CLLocation(latitude: 55.0598,
                                         longitude: 37.4103)


//    func generateRandomPlacemark() -> CLPlacemark {
//        // Случайные координаты
//        let latitude = CLLocationDegrees.random(in: -90...90)
//        let longitude = CLLocationDegrees.random(in: -180...180)
//        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//
//        // Случайные данные для адреса
//        let addressDictionary: [String: Any] = [
//            CNPostalAddressStreetKey: "Random Street \(Int.random(in: 1...100))",
//            CNPostalAddressCityKey: "Random City",
//            CNPostalAddressStateKey: "Random State",
//            CNPostalAddressPostalCodeKey: "\(Int.random(in: 10000...99999))",
//            CNPostalAddressCountryKey: "Random Country",
//            CNPostalAddressISOCountryCodeKey: "RC"
//        ]
//
//        // Создаем CLLocation
//        let location = CLLocation(latitude: latitude, longitude: longitude)
//
//        // Создаем CLPlacemark
//        let placemark = CLPlacemark
//
//        return placemark
//    }
}
