import SwiftUI
import MapKit
import Contacts

final class TempDatabase: ObservableObject {

    static let shared = TempDatabase()

    @Published var myEvents: [Event] = []
    @Published var subscriptions: [Event] = []

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
        let title3 = "ищу человека для похода в кино на фильм ПРОРОК ищу"

        let seats1 = Seats(busy: 0, all: 21)
        let seats2 = Seats(busy: 0, all: 3000)
        let seats3 = Seats(busy: 0, all: 1)

        let link1 = "https://github.com/ilyansky/born2code"
        let link2 = "https://github.com/ilyansky/VKTestTask"
        let link3 = "\n😄\t😄\0\r"

        let date = Date()

        let geopoint1 = CLLocation(latitude: 55.7558, longitude: 37.6173)
        let geopoint2 = CLLocation(latitude: 56.7558, longitude: 37.6173)
        let geopoint3 = CLLocation(latitude: 57.7558, longitude: 37.6173)

        let place1 = Place(
            location: geopoint1,
            placeDescription: "Германия\nКерпен\nHeribertstraße\n37\n\nШирота: 50.8651\nДолгота: 6.5811"
        )
        let place2 = Place(
            location: geopoint2,
            placeDescription: "Kromme Rijn\n\nШирота: 52.0571\nДолгота: 5.2405"
        )
        let place3 = Place(
            location: geopoint3,
            placeDescription: "Северный Атлантический океан\n\nШирота: 44.5782\nДолгота: 13.2687"
        )

        let event1 = Event(image: image1, title: title1, seats: seats1, link: link1, date: date, place: place1)
        let event2 = Event(image: image2, title: title2, seats: seats2, link: link2, date: date, place: place2)
        let event3 = Event(image: image3, title: title3, seats: seats3, link: link3, date: date, place: place3)

        myEvents.append(event1)
        myEvents.append(event2)
        myEvents.append(event3)
    }
}
