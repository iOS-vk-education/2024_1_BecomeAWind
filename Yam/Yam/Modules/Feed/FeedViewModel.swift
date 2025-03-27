import Foundation
import Combine
import SwiftUI

final class FeedViewModel: ObservableObject {

    @ObservedObject var db = TempDatabase.shared
    @Published var allEvents: [Event] = []

    init() { updateFeed() }

    func updateFeed() {
        allEvents = db.get(.all)
    }

}

extension FeedViewModel: EventCardProtocol {

    func toggleEdit(event: Event) {
//        print(#function)
    }

    func toggleLocation(for event: Event) {
//        print(#function)
    }

    func open(link: String) {
        print(#function)
    }

    func handleSubscribeButton(for event: Event) {
        print(#function)
    }

    func convertToString(from seats: Seats) -> String {
        EventHandler.getSeatsString(from: seats)
    }

    func convertToString(from date: Date) -> String {
        EventHandler.getDateString(from: date)
    }

}
