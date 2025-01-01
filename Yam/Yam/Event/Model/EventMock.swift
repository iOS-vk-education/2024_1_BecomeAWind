//
//  EventMock.swift
//  Yam
//
//  Created by Ширапов Арсалан on 01.01.2025.
//

import Foundation

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
            imageName: "basketball",
            category: .sport
        ),
        EventDescription(
            title: "Футбол",
            description: """
            Привет! Сегодня в 18:00 мы с друзьями хотим провести дружеский матч, но нас не так много. 
            Нужно 7 человек. Желающие поиграть, повеселиться и обрести новые знакомства, 
            мы вас ждем зажидаемся!! 
            """,
            imageName: "footbal",
            category: .sport
        ),
    ]
}

private struct RandomEventOrganizationInformation {
    let info: [EventOrganizationInformation] = [
        EventOrganizationInformation(
            place: "Ул. России 17",
            freePlaces: 7,
            link: "https://t.me/bobs"
        )
    ]
}
