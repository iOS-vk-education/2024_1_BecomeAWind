import Foundation

protocol YEventCardProtocol {

    func toggleEditEvent(for event: Event)

    func toggleEventLocation(for event: Event)

    func openLink(_ link: String)

    func handleSubscribeButton(for event: Event)

    func getSeatsString(from seats: Seats) -> String

    func getDateString(from date: Date) -> String

}
