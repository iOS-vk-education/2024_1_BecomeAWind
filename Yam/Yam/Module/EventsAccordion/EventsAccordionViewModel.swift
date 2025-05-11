import Foundation
import SwiftUI

final class EventsAccordionViewModel: ObservableObject {

    private let dbService = DatabaseService.shared
    private let authInteractor = AuthInteractor.shared
    @Published var eventPack: [Event]

    // EventCardViewModelProtocol
    @Published var selectedEvent: Event?
    @Published var invalidLink = false
    @Published var isActiveEventLocation = false
    @Published var isActiveBuildEvent = false
    @Published var subscribeFail = false
    @Published var unsubcribeFail = false
    @Published var fail = false

    init(eventPack: [Event]) {
        self.eventPack = eventPack
    }

    func getEventType(_ event: Event) -> EventType {
        if dbService.myEventsIDs.contains(event.id) {
            return .my
        } else if dbService.subscriptionsIDs.contains(event.id) {
            return .added
        } else {
            return .notAdded
        }
    }

    private func getEventIDs() async {
        guard let userID = authInteractor.getUserID() else { return }

        await dbService.getEventIDs(userID: userID, my: true)
        await dbService.getEventIDs(userID: userID, my: false)
    }

}

// MARK: - Support

extension EventsAccordionViewModel {

    func getHeaderText() -> String {
        "ивентов поблизости: \(eventPack.count)"
    }

}

extension EventsAccordionViewModel: EventCardViewModelProtocol {

    func showBuildEvent(for event: Event) {
        selectedEvent = event
        isActiveBuildEvent = true
    }

    func showLocation(of event: Event) {
        selectedEvent = event
        isActiveEventLocation = true
    }

    func open(link: String) {
        if !EventHandler.openLink(link) {
            invalidLink = true
        }
    }

    @MainActor
    func handleSubscribeButton(event: Event, eventType: EventType) async -> Bool {
        guard let userID = authInteractor.getUserID() else {
            fail = true
            return !fail
        }

        selectedEvent = event

        switch eventType {
        case .added:
            guard let newEvent = await getNewEvent(
                userID: userID,
                event: event,
                eventType: eventType,
                subscriptionsContainsEvent: dbService.subscriptionsIDs.contains(event.id)
            ) else {
                unsubcribeFail = true
                return !unsubcribeFail
            }

            unsubcribeFail = await !dbService.unsubscribeToTheEvent(
                userID: userID,
                event: newEvent
            )

            return !unsubcribeFail

        case .notAdded:
            guard let newEvent = await getNewEvent(
                userID: userID,
                event: event,
                eventType: eventType,
                subscriptionsContainsEvent: dbService.subscriptionsIDs.contains(event.id)
            ) else {
                subscribeFail = true
                return !subscribeFail
            }

            subscribeFail = await !dbService.subscribeToTheEvent(userID: userID, event: newEvent)

            return !subscribeFail

        default:
            fail = true
            return !fail
        }
    }

    @MainActor
    func updateEvent(eventID: String) async {
        await getEventIDs()

        do {
            let updatedEvent = try await dbService.getEventFromFeed(by: eventID)

            if let index = eventPack.firstIndex(where: { $0.id == updatedEvent.id }) {
                eventPack[index] = updatedEvent
            }

            Logger.Feed.eventUpdated()
        } catch {
            if let index = eventPack.firstIndex(where: { $0.id == eventID} ) {
                eventPack.remove(at: index)
                Logger.Feed.eventUpdated()
            } else {
                Logger.Feed.eventNotUpdated()
            }
        }
    }

}
