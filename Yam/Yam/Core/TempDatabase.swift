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
        generateEvents()
        print("TempDatabase initialized")
    }

    func generateEvents() {
        let image1 = UIImage(named: "football")!
        let image2 = UIImage(named: "projectx")!
        let image3 = UIImage(named: "default_event_image")!

        let title1 = "матч в футбол 11 на 11"
        let title2 = "поход на концерт Нейромонаха Феофана"
        let title3 = "ищу человека для похода в кино на фильм ПРОРОК"

        let seats1 = 21
        let seats2 = 3000
        let seats3 = 1

        let link1 = "https://github.com/ilyansky/born2code"
        let link2 = "https://github.com/ilyansky/VKTestTask"
        let link3 = "invalid url"
        let date = Date()

        let geopoint1 = CLLocation(latitude: 55.7558, longitude: 37.6173)
        let geopoint2 = CLLocation(latitude: 56.7558, longitude: 37.6173)
        let geopoint3 = CLLocation(latitude: 57.7558, longitude: 37.6173)

        let event1 = Event(image: image1, title: title1, seats: seats1, link: link1, date: date, geopoint: geopoint1)
        let event2 = Event(image: image2, title: title2, seats: seats2, link: link2, date: date, geopoint: geopoint2)
        let event3 = Event(image: image3, title: title3, seats: seats3, link: link3, date: date, geopoint: geopoint3)

        events.append(event1)
        events.append(event2)
        events.append(event3)
    }

//    @Published var location1 = CLLocation(latitude: 55.9558,
//                                         longitude: 37.2173)
//    @Published var location2 = CLLocation(latitude: 55.5568,
//                                         longitude: 37.1143)
//    @Published var location3 = CLLocation(latitude: 55.0598,
//                                         longitude: 37.4103)


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
