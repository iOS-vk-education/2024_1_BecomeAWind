import Foundation

protocol EventCardViewModelProtocol {

    func toggleAction(event: Event)

    func toggleLocation(for event: Event)

    func open(link: String)

    func handleSubscribeButton(for event: Event)

    func convertToString(from seats: Seats) -> String

    func convertToString(from date: Date) -> String

}
