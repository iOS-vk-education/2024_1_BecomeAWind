import Foundation
import Combine
import SwiftUI

final class FeedViewModel: ObservableObject {

    @ObservedObject var db = TempDatabase.shared
    @Published var allEvents: [Event] = []
    @Published var filteredEvents: [Event] = []

    init() { updateFeed() }

    func updateFeed() {
        allEvents = db.get(.all)
        filteredEvents = allEvents
    }

}

extension FeedViewModel: EventCardProtocol {
    func filterEvents(by searchText: String) {
        if searchText.isEmpty {
            filteredEvents = allEvents
        } else {
            filteredEvents = allEvents.filter { event in
                event.title.lowercased().contains(searchText.lowercased())
            }
        }
    }

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
