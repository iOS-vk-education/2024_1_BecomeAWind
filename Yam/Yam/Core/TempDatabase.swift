import SwiftUI
import MapKit

protocol DatabaseDescription {
    func add(event: UIEvent)
    func edit(event: UIEvent)
    func get(_ type: EventType) -> [UIEvent]
}

enum EventType {
    case my
    case subscriptions
    case all
}

final class TempDatabase: ObservableObject {

    static let shared = TempDatabase()

    private var myEvents: [UIEvent] = []
    private var subscriptions: [UIEvent] = []
    private var allEvents: [UIEvent] = []

    private init() {
        generateEvents()
        Logger.Database.databaseInit()
    }

    private func generateEvents() {
        let image1 = UIImage(named: "football")!
        let image2 = UIImage(named: "projectx")!
        let image3 = UIImage(named: "default_event_image")!
        let image4 = UIImage(named: "chess")!

        let title1 = "матч в футбол 11 на 11"
        let title2 = "поход на концерт Нейромонаха Феофана"
        let title3 = "ищу человека для похода в кино на фильм ПРОРОК ищу"
        let title4 = "партия в шахматы"

        let seats1 = Seats(busy: 0, all: 21)
        let seats2 = Seats(busy: 0, all: 3000)
        let seats3 = Seats(busy: 0, all: 1)
        let seats4 = Seats(busy: 0, all: 1)

        let link1 = "https://github.com/ilyansky/born2code"
        let link2 = "https://github.com/ilyansky/VKTestTask"
        let link3 = "\n😄\t😄\0\r"
        let link4 = "https://github.com/ilyansky/born2code"

        let date = Date()

        let geopoint1 = CLLocation(latitude: 50.8651, longitude: 6.5811)
        let geopoint2 = CLLocation(latitude: 52.0571, longitude: 5.2405)
        let geopoint3 = CLLocation(latitude: 44.5782, longitude: 13.2687)
        let geopoint4 = CLLocation(latitude: 44.5782, longitude: 44.5782)

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
        let place4 = Place(
            location: geopoint4,
            placeDescription: "Северный Атлантический океан\n\nШирота: 44.5782\nДолгота: 44.5782"
        )

        let event1 = UIEvent(image: image1, title: title1, seats: seats1, link: link1, date: date, place: place1)
        let event2 = UIEvent(image: image2, title: title2, seats: seats2, link: link2, date: date, place: place2)
        let event3 = UIEvent(image: image3, title: title3, seats: seats3, link: link3, date: date, place: place3)
        let event4 = UIEvent(image: image4, title: title4, seats: seats4, link: link4, date: date, place: place4)


        myEvents.append(event1)
        myEvents.append(event2)

        subscriptions.append(event4)
        subscriptions.append(event3)

        allEvents.append(event1)
        allEvents.append(event2)
        allEvents.append(event4)
        allEvents.append(event3)
    }

}

extension TempDatabase: DatabaseDescription {

    func add(event: UIEvent) {
        myEvents.append(event)
    }

    func get(_ type: EventType) -> [UIEvent] {
        switch type {
        case .my: myEvents
        case .subscriptions: subscriptions
        case .all: allEvents
        }
    }

    func edit(event: UIEvent) {
        guard let index = myEvents.firstIndex(where: {$0.id == event.id}) else { return }
        if myEvents[index] != event {
            myEvents[index] = event
        }
    }

}
