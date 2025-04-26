import Foundation
import Combine
import SwiftUI

final class FeedViewModel: ObservableObject {

    @ObservedObject var db = TempDatabase.shared
    @Published var allEvents: [UIEvent] = []

    init() { updateFeed() }

    func updateFeed() {
//        allEvents = db.get(.all)
    }

}

extension FeedViewModel/*: EventCardViewModelProtocol*/ {

    func toggleEdit(event: UIEvent) {
//        print(#function)
    }

    func toggleLocation(for event: UIEvent) {
//        print(#function)
    }

    func open(link: String) {
//        print(#function)
    }

    func handleSubscribeButton(for event: UIEvent) {
//        print(#function)
    }

    func convertToString(from seats: Seats) -> String {
        EventHandler.getSeatsString(from: seats)
    }

    func convertToString(from date: Date) -> String {
        EventHandler.getDateString(from: date)
    }

}
