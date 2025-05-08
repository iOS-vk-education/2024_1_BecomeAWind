import Foundation
import SwiftUI

final class EventsAccordionViewModel: ObservableObject {

    private let dbService = DatabaseService.shared
    let eventPack: [Event]

    // EventCardViewModelProtocol
    @Published var selectedEvent: Event?
    @Published var invalidLink = false
    @Published var isActiveEventLocation = false
    @Published var isActiveBuildEvent = false
    @Published var subscribeFail = false
    @Published var unsubcribeFail = false
    @Published var fail = false

    init(eventPack: [Event]) {
        self.eventPack = eventPack
    }

    func getEventType(_ event: Event) -> EventType {
        if dbService.myEventsIDs.contains(event.id) {
            return .my
        } else if dbService.subscriptionsIDs.contains(event.id) {
            return .added
        } else {
            return .notAdded
        }
    }

}

extension EventsAccordionViewModel: EventCardViewModelProtocol {

    func showBuildEvent(for event: Event) {
        selectedEvent = event
        isActiveBuildEvent = true
    }

    func showLocation(of event: Event) {
        selectedEvent = event
        isActiveEventLocation = true
    }

    func open(link: String) {
        if !EventHandler.openLink(link) {
            invalidLink = true
        }
    }

    func handleSubscribeButton(event: Event, eventType: EventType) async -> Bool {
        Logger.ping()
        return false
    }

    func updateEvent(eventID: String) async {
        Logger.ping()
    }

}
