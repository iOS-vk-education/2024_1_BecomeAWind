import Foundation
import MapKit

struct EventsMock {
    private let generator = EventGenerator()

    func getEvents() -> [Event] {
        generator.makeEvents()
    }
}

private struct EventGenerator {
    private let descriptions = RandomEventDescription()
    private let organizationInfo = RandomEventOrganizationInformation()

    func makeEvents() -> [Event] {
        var events: [Event] = []

        for description in descriptions.info {
            let indexOrg = Int.random(in: 0..<organizationInfo.info.count)
            let event = Event(description: description, organization: organizationInfo.info[indexOrg])
            events.append(event)
        }

        return events
    }
}

private struct RandomEventDescription {
    let info: [EventDescription] = [

        EventDescription(
            title: "Баскетбол",
            description: """
            Нужен 1+ человек на игру в “33”,
            хотите поиграть, но не знаете правила - объясню, только скорее приходите,
            мне очень скучно
            """,
            image: UIImage(named: "defaulteventimage")!
//            category: .sport
        ),
        EventDescription(
            title: "Футбол",
            description: """
            Привет! Сегодня в 18:00 мы с друзьями хотим провести дружеский матч, но нас не так много.
            Нужно 7 человек. Желающие поиграть, повеселиться и обрести новые знакомства,
            мы вас ждем зажидаемся!! 
            """,
            image: UIImage(named: "defaulteventimage")!
//            category: .sport
        ),
        EventDescription(
            title: "Тусовка по репосту",
            description: """
            Сделайте репост и попадайте на нашу крупнейшую тусовку в москве!!
            """,
            image: UIImage(named: "defaulteventimage")!
//            category: .entertainments
        ),
        EventDescription(
            title: "Игра в шахматы",
            description: """
            У нас проводится турнир по шахматам с денежным призом! Приходите и сражайтесь умами за первое место!!
            """,
            image: UIImage(named: "defaulteventimage")!
//            category: .sport
        ),
        EventDescription(
            title: "Пати в кску",
            description: """
            Хочу нормально апнуть рейтинга на фейсите, нужны тиммейты!!
            """,
            image: UIImage(named: "defaulteventimage")!
//            category: .sport
        ),
        EventDescription(
            title: "Фильмец",
            description: """
            Мой друг заболел и не сможет пойти на фильм, есть один билет кто пойдет вместо него?
            """,
            image: UIImage(named: "defaulteventimage")!
//            category: .entertainments
        )
    ]
}

private struct RandomEventOrganizationInformation {
    let info: [EventOrganizationInformation] = [
        EventOrganizationInformation(
            date: DateModel(date: Date(), timeZome: TimeZone.current),
            place: "Ул. Строгино, д. 7",
            seats: 7,
            link: "https://t.me/bobs"
        )
    ]
}
