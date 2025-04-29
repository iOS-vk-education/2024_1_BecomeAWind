import Foundation
import Combine
import SwiftUI

final class FeedViewModel: ObservableObject {

    private let authInteractor = AuthInteractor.shared
    private let dbService = DatabaseService.shared

    @Published var allEvents: [Event] = []

    /// event card
    @Published var selectedEvent: Event?
    @Published var invalidLink = false
    @Published var isActiveEventLocation = false

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

    func toggleAction(for event: Event) {}

    func toggleLocation(for event: Event) {
        selectedEvent = event
        isActiveEventLocation.toggle()
    }

    func open(link: String) {
        if !EventHandler.openLink(link) {
            invalidLink.toggle()
        }
    }

    func handleSubscribeButton(for event: Event) {
        if 
    }

}
