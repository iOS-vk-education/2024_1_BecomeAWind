import Foundation

protocol EventCardViewModelProtocol {

    var selectedEvent: Event? { get set }
    var invalidLink: Bool { get set }
    var isActiveEventLocation: Bool { get set }
    var isActiveAction: Bool { get set }

    func toggleAction(for event: Event)

    func toggleLocation(for event: Event)

    func open(link: String)

    func handleSubscribeButton(for event: Event, eventType: EventType) async -> Bool

}

extension EventCardViewModelProtocol {

    func convertToString(from seats: Seats) -> String {
        EventHandler.getSeatsString(from: seats)
    }

    func convertToString(from date: Date) -> String {
        EventHandler.getDateString(from: date)
    }

}
