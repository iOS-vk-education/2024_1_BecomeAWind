import SwiftUI
import FirebaseFirestore

final class MyEventsViewModel: ObservableObject {

    private let authInteractor = AuthInteractor.shared
    private let dbService = DatabaseService.shared

    @Published var myEvents: [Event] = []

    @Published var isActiveCreateEvent = false

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
    var lastDoc: DocumentSnapshot? = nil
    var isEndReached = false
    var isFirstPack = true {
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

    func showCreateEvent() {
        isActiveCreateEvent = true
    }

    private func getEventIDs() async {
        guard let userID = authInteractor.getUserID() else { return }

        await dbService.getEventIDs(userID: userID, my: true)
    }

}

// MARK: - EventCard

extension MyEventsViewModel: EventCardViewModelProtocol {

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

    func handleSubscribeButton(event: Event, eventType: EventType) async -> Bool {
        return false
    }

    @MainActor
    func updateEvent(eventID: String) async {
        do {
            let updatedEvent = try await dbService.getEventFromFeed(by: eventID)

            await getEventIDs()

            if let index = myEvents.firstIndex(where: { $0.id == updatedEvent.id }) {
                myEvents[index] = updatedEvent
            }

            Logger.Feed.eventUpdated()
        } catch {
            Logger.Feed.eventNotUpdated(error)
        }
    }

}

// MARK: - Table

extension MyEventsViewModel: TableFetchDataProtocol {

    func removeEventFromTable(eventID: String) {
        guard let index = myEvents.firstIndex(where: { $0.id == eventID} ) else {
            Logger.MyEvents.eventNotRemovedFromTable(eventID: eventID)
            return
        }


        myEvents.remove(at: index)
        Logger.MyEvents.eventRemovedFromTable(eventID: eventID)
    }

    @MainActor
    func loadItems(isFirstPack: Bool) async {
        guard let userID = authInteractor.getUserID(),
              !isLoading,
              !isEndReached else { return }

        if isFirstPack {
            await getEventIDs()
        }

        isLoading = true

        let result: (events: [Event], newLastDoc: DocumentSnapshot?, isEndReached: Bool)
        result = await dbService.loadEvents(isMy: true, for: userID, lastDoc: isFirstPack ? nil : lastDoc)
        myEvents = isFirstPack ? result.events : myEvents + result.events

        lastDoc = result.newLastDoc
        isEndReached = result.isEndReached

        isLoading = false

        if isFirstPack { self.isFirstPack = false }
    }

    @MainActor
    func refresh() async {
        guard !isLoading else { return }

        isLoading = true

        myEvents.removeAll()
        isFirstPack = true
        lastDoc = nil
        isEndReached = false

        isLoading = false
    }

}
