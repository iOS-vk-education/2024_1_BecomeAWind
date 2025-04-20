import Foundation

protocol EventCardViewModelProtocol {

    func toggleEdit(event: UIEvent)

    func toggleLocation(for event: UIEvent)

    func open(link: String)

    func handleSubscribeButton(for event: UIEvent)

    func convertToString(from seats: Seats) -> String

    func convertToString(from date: Date) -> String

}
