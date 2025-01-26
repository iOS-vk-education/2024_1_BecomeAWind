import SwiftUI
import MapKit

final class TempDatabase: ObservableObject {
    static let shared = TempDatabase()
    @Published var events: [Event] = []

    private init() {
        print("TempDatabase initialized")
        initEvents()
    }

    private func initEvents() {
        let event1 = Event(description: EventDescription(title: "Мероприятие 1 \nМероприятие 1 \nМероприятие 1 \nМероприятие 1 \nМероприятие 1 \nМероприятие 1 \nМероприятие 1 \nМероприятие 1",
                                                        description: "Это мероприятие создано в целях тестирования",
                                                        image: UIImage(named: "defaulteventimage")!),
                          organization: EventOrganizationInformation(date: DateModel(date: Date(),
                                                                                     timeZome: TimeZone.current),
                                                                     place: "Тестовая улица где-то в МСК",
                                                                     seats: 13,
                                                                     link: "https://contact/event/author"))

        let event2 = Event(description: EventDescription(title: "Мероприятие 2 Мероприятие 2 Мероприятие 2 Мероприятие 2 Мероприятие 2 Мероприятие 2 Мероприятие 2 Мероприятие 2 Мероприятие 2 Мероприятие 2 Мероприятие 2 Мероприятие 2 Мероприятие 2 Мероприятие 2",
                                                         description: "Это мероприятие создано в целях тестирования",
                                                         image: UIImage(named: "defaulteventimage")!),
                           organization: EventOrganizationInformation(date: DateModel(date: Date(),
                                                                                      timeZome: TimeZone.current),
                                                                      place: "Тестовая улица где-то в МСК",
                                                                      seats: 4,
                                                                      link: "https://contact/event/author"))

        let event3 = Event(description: EventDescription(title: "Мероприятие 3",
                                                         description: "Это мероприятие создано в целях тестирования",
                                                         image: UIImage(named: "defaulteventimage")!),
                           organization: EventOrganizationInformation(date: DateModel(date: Date(),
                                                                                      timeZome: TimeZone.current),
                                                                      place: "Тестовая улица где-то в МСК",
                                                                      seats: 1,
                                                                      link: "https://contact/event/author"))
        events = [event1, event2, event3]
    }

    @Published var location1 = CLLocation(latitude: 55.9558,
                                         longitude: 37.2173)
    @Published var location2 = CLLocation(latitude: 55.5568,
                                         longitude: 37.1143)
    @Published var location3 = CLLocation(latitude: 55.0598,
                                         longitude: 37.4103)
}
