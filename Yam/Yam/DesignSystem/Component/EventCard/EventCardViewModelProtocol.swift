import Foundation

protocol EventCardViewModelProtocol {

    var selectedEvent: Event? { get set }
    var invalidLink: Bool { get set }
    var isActiveEventLocation: Bool { get set }
    var isActiveAction: Bool { get set }
    var failedToSubcribeAlert: Bool { get set }
    var failedToUnsubcribeAlert: Bool { get set }
    var fail: Bool { get set }

    func toggleAction(for event: Event)

    func toggleLocation(for event: Event)

    func open(link: String)

    func handleSubscribeButton(
        event: Event,
        eventType: EventType,
    ) async -> Bool

    func updateEvent(eventID: String) async

}

extension EventCardViewModelProtocol {

    func getNewEvent(
        userID: String,
        event: Event,
        eventType: EventType,
        subscriptionsContainsEvent: Bool
    ) async -> Event? {

        switch eventType {
        case .added:
            guard subscriptionsContainsEvent &&
                    event.seats.busy > 0 else {
                return nil
            }

            var newEvent = event
            newEvent.seats.busy -= 1

            return newEvent

        case .notAdded:
            guard !subscriptionsContainsEvent &&
                    event.seats.busy < event.seats.all else {
                return nil
            }

            var newEvent = event
            newEvent.seats.busy += 1

            return newEvent

        default: return nil
        }
        
    }

    func convertToString(from seats: Seats) -> String {
        EventHandler.getSeatsString(from: seats)
    }

    func convertToString(from date: Date) -> String {
        EventHandler.getDateString(from: date)
    }

}
