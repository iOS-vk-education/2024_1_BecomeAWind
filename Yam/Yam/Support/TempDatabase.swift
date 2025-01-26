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
        let event1 = Event(description: EventDescription(title: "Партия в шахматы",
                                                         description: """
Значимость этих проблем настолько очевидна, что граница обучения кадров создаёт необходимость включения в производственный план целого ряда внеочередных мероприятий с учётом комплекса экспериментов, поражающих по своей масштабности и грандиозности. Не следует, однако, забывать, что разбавленное изрядной долей эмпатии, рациональное мышление представляет собой интересный эксперимент проверки глубокомысленных рассуждений. С другой стороны, пот проверки глубокомысленных рассуждений. С другой стороны, по
""",
                                                         image: UIImage(named: "chess")!),
                          organization: EventOrganizationInformation(date: DateModel(date: Date(),
                                                                                     timeZome: TimeZone.current),
                                                                     place: "Тестовая улица где-то в МСК",
                                                                     seats: 1,
                                                                     link: "https://t.me/iilyansky"))

        let event2 = Event(description: EventDescription(title: "123456789012345678901234567890",
                                                         description: "Рыбатекст используется дизайнерами, проектировщиками и фронтендерами, когда нужно быстро заполнить макеты или прототипы содержимым. Это тестовый контент, который не должен нести никакого смысла, ",
                                                         image: UIImage(named: "defaulteventimage")!),
                           organization: EventOrganizationInformation(date: DateModel(date: Date(),
                                                                                      timeZome: TimeZone.current),
                                                                      place: "Москва, ул. Строгино, 7",
                                                                      seats: 4,
                                                                      link: "https://contact/event/author"))

        let event3 = Event(description: EventDescription(title: "Игра в футбол",
                                                         description: "Ищем команду для игры в футбол +5",
                                                         image: UIImage(named: "football")!),
                           organization: EventOrganizationInformation(date: DateModel(date: Date(),
                                                                                      timeZome: TimeZone.current),
                                                                      place: "Тест тест тест лорем ипсум",
                                                                      seats: 5,
                                                                      link: "https://contact/event/author/asdas/asdasd/asdasd/asdasd/asdasd/asdasd/asdasd/asdasd"))
        events = [event1, event2, event3]
    }

    @Published var location1 = CLLocation(latitude: 55.9558,
                                         longitude: 37.2173)
    @Published var location2 = CLLocation(latitude: 55.5568,
                                         longitude: 37.1143)
    @Published var location3 = CLLocation(latitude: 55.0598,
                                         longitude: 37.4103)
}
