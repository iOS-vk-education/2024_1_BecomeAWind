import Foundation

protocol EventCardViewModelProtocol {

    func toggleAction(for event: Event)

    func toggleLocation(for event: Event)

    func open(link: String)

    func handleSubscribeButton(for event: Event)

}

extension EventCardViewModelProtocol {

    func convertToString(from seats: Seats) -> String {
        EventHandler.getSeatsString(from: seats)
    }

    func convertToString(from date: Date) -> String {
        EventHandler.getDateString(from: date)
    }

}
