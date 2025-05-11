import SwiftUI
import FirebaseFirestore

final class FeedViewModel: ObservableObject {

    private let authInteractor = AuthInteractor.shared
    @State var dbService = DatabaseService.shared

    @Published var feedEvents: [Event] = []

    // EventCardViewModelProtocol
    @Published var selectedEvent: Event?
    @Published var invalidLink = false
    @Published var isActiveEventLocation = false
    @Published var isActiveBuildEvent = false
    @Published var subscribeFail = false
    @Published var unsubcribeFail = false
    @Published var fail = false

    // TableFetchDataProtocol
    @Published var isLoading = false
    var isFirstPack = true
    var lastDoc: DocumentSnapshot? = nil
    var isEndReached = false {
        didSet {
            Task {
                await loadItems(isFirstPack: isFirstPack)
            }
        }
    }

    init() {
        Task {
            await loadItems(isFirstPack: isFirstPack)
        }
    }

}

// MARK: - Support

extension FeedViewModel {

    func getFeedEventsCount() -> String {
        let count = feedEvents.filter { !dbService.myEventsIDs.contains($0.id) }.count
        return EventHandler.getEventsCountString(count)
    }

    private func getEventIDs() async {
        guard let userID = authInteractor.getUserID() else { return }

        await dbService.getEventIDs(userID: userID, my: true)
        await dbService.getEventIDs(userID: userID, my: false)
    }

}

extension FeedViewModel: EventCardViewModelProtocol {

    func showBuildEvent(for event: Event) {}

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
        do {
            let updatedEvent = try await dbService.getEventFromFeed(by: eventID)

            await getEventIDs()
            if let index = feedEvents.firstIndex(where: { $0.id == updatedEvent.id }) {
                feedEvents[index] = updatedEvent
            }
            
            Logger.Feed.eventUpdated()
        } catch {
            Logger.Feed.eventNotUpdated(error)
        }
    }

}

extension FeedViewModel: TableFetchDataProtocol {

    @MainActor
    func loadItems(isFirstPack: Bool) async {
        guard !isLoading,
              !isEndReached else { return }

        if isFirstPack {
            await getEventIDs()
        }

        isLoading = true

        let result = isFirstPack
        ? await dbService.loadFeed(lastDoc: nil)
        : await dbService.loadFeed(lastDoc: lastDoc)

        if isFirstPack {
            feedEvents = result.events
        } else {
            feedEvents.append(contentsOf: result.events)
        }

        lastDoc = result.newLastDoc
        isEndReached = result.isEndReached

        isLoading = false

        if isFirstPack { self.isFirstPack = false }
    }


    @MainActor
    func refresh() async {
        guard !isLoading else { return }

        isLoading = true

        feedEvents.removeAll()
        isFirstPack = true
        lastDoc = nil
        isEndReached = false

        isLoading = false
    }

}
