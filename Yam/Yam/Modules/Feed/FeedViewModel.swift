import Foundation
import Combine
import SwiftUI

final class FeedViewModel: ObservableObject {

    private let authInteractor = AuthInteractor.shared
    private let dbService = DatabaseService.shared

    @Published var allEvents: [Event] = []

    init() {
        Task { @MainActor in
            await getFeed()
        }

    }

    @MainActor
    func getFeed() async {
        let allEvents = await dbService.getAllEvents()
        self.allEvents = allEvents
    }

}

extension FeedViewModel: EventCardViewModelProtocol {

    func toggleAction(event: Event) {
//        print(#function)
    }

    func toggleLocation(for event: Event) {
//        print(#function)
    }

    func open(link: String) {
//        print(#function)
    }

    func handleSubscribeButton(for event: Event) {
//        print(#function)
    }

    func convertToString(from seats: Seats) -> String {
        EventHandler.getSeatsString(from: seats)
    }

    func convertToString(from date: Date) -> String {
        EventHandler.getDateString(from: date)
    }

}
