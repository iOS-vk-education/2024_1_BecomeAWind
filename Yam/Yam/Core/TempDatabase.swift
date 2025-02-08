import SwiftUI
import MapKit

// singleton
final class TempDatabase: ObservableObject {
    static let shared = TempDatabase()
    
    @Published var events: [Event] = []
    @Published var users: [UserModel] = [
        UserModel(login: "1", email: "1", password: "1"),
        UserModel(login: "2", email: "2", password: "2"),
        UserModel(login: "3", email: "3", password: "3")
    ]

    private init() {
        print("TempDatabase initialized")
        generateEvents(0)
        generateEvents(1)
        generateEvents(2)
    }

    func generateEvents(_ now: Int) {
        let coordinates = [
            CLLocationCoordinate2D(latitude: 55.7558, longitude: 37.6173),
            CLLocationCoordinate2D(latitude: 59.9343, longitude: 30.3351),
            CLLocationCoordinate2D(latitude: 48.8566, longitude: 2.3522)
        ]

        let eventDescriptions = [
            EventDescription(title: "Концерт в Москве", description: "Уникальное музыкальное событие в центре Москвы.", image: UIImage(named: "projectx")!),
            EventDescription(title: "Театральная постановка", description: "Новый спектакль в Санкт-Петербурге.", image: UIImage(named: "film")!),
            EventDescription(title: "Выставка искусства", description: "Крупнейшая выставка искусства в Париже.", image: UIImage(named: "chess")!)
        ]

        let eventDates = [
            DateModel(date: Date(), timeZone: TimeZone.current),
            DateModel(date: Date().addingTimeInterval(60*60*24*10), timeZone: TimeZone.current),
            DateModel(date: Date().addingTimeInterval(60*60*24*20), timeZone: TimeZone.current)
        ]

        let seatsArray = [200, 150, 300]

        let links = [
            "https://developer.apple.com/documentation/foundation/dateformatter",
            "https://github.com/ilyansky/born2code",
            "https://t.me/iilyansky"
        ]

        let geocoder = CLGeocoder()

//        func getPlacemark(for coordinate: CLLocationCoordinate2D, completion: @escaping (CLPlacemark?) -> Void) {
//            geocoder.reverseGeocodeLocation(CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude), preferredLocale: Locales.ru) { placemarks, _ in
//                if let placemark = placemarks?.first {
//                    completion(placemark)
//                } else {
//                    completion(nil)
//                }
//            }
//        }

//        getPlacemark(for: coordinates[now]) { placemark in
//                let event = Event(
//                    description: eventDescriptions[now],
//                    organization: EventOrganizationInformation(
//                        date: eventDates[now],
//                        place: placemark != nil ? PlaceModel(placemark: placemark!, coordinate: coordinates[now]) : nil,
//                        seats: seatsArray[now],
//                        link: links[now]
//                    )
//                )
//                self.events.append(event)
//            }
    }

    @Published var location1 = CLLocation(latitude: 55.9558,
                                         longitude: 37.2173)
    @Published var location2 = CLLocation(latitude: 55.5568,
                                         longitude: 37.1143)
    @Published var location3 = CLLocation(latitude: 55.0598,
                                         longitude: 37.4103)
}
