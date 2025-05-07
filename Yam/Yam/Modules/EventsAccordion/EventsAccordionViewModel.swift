import Foundation
import SwiftUI

final class EventsAccordionViewModel: ObservableObject {

    let numberOfEvents: Int

    // EventCardViewModelProtocol
    var selectedEvent: Event?
    var invalidLink = false
    var isActiveEventLocation = false
    var isActiveAction = false
    var failedToSubcribeAlert = false
    var failedToUnsubcribeAlert = false
    var fail = false

    init(numberOfEvents: Int) {
        self.numberOfEvents = numberOfEvents
    }

}

extension EventsAccordionViewModel: EventCardViewModelProtocol {

    func toggleAction(for event: Event) {
        Logger.ping()
    }

    func toggleLocation(for event: Event) {
        Logger.ping()
    }

    func open(link: String) {
        Logger.ping()
    }

    func handleSubscribeButton(event: Event, eventType: EventType) async -> Bool {
        Logger.ping()
        return false
    }

    func updateEvent(eventID: String) async {
        Logger.ping()
    }

}
