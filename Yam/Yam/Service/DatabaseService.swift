import Foundation
import FirebaseFirestore

final class DatabaseService {

    static let shared = DatabaseService()
    private let db = Firestore.firestore()

    private var myEventsIDsTempStorage = [String]()

    private init() {}

    ///
    private func getUsersCollection() -> CollectionReference {
        db.collection("users")
    }

    private func getUserDoc(userID: String) -> DocumentReference {
        getUsersCollection().document(userID)
    }

    ///
    private func getFeedCollection() -> CollectionReference {
        db.collection("feed")
    }

    private func getEventInFeed(eventID: String) -> DocumentReference {
        getFeedCollection().document(eventID)
    }

    ///
    private func getMyEventsCollection(userID: String) -> CollectionReference {
        getUserDoc(userID: userID).collection("myEvents")
    }

    private func getSubscriptionsCollection(userID: String) -> CollectionReference {
        getUserDoc(userID: userID).collection("subscriptions")
    }

    private func getEventInMyEvents(userID: String, eventID: String) -> DocumentReference {
        getMyEventsCollection(userID: userID).document(eventID)
    }

    private func getEventInSubscriptions(userID: String, eventID: String) -> DocumentReference {
        getSubscriptionsCollection(userID: userID).document(eventID)
    }

}

// MARK: - Auth

extension DatabaseService {

    func createUser(user: YUser, completion: @escaping (Result<YUser, Error>) -> Void) {
        getUserDoc(userID: user.id).setData(user.representation) { error in
            if let error {
                completion(.failure(error))
                Logger.Auth.userNotAddedToDatabase(error: error)
            } else {
                completion(.success(user))
                Logger.Auth.userAddedToDatabase()
            }
        }
    }

}

// MARK: - Events

extension DatabaseService {

    func loadEvents(
        isMy: Bool,
        for userID: String,
        lastDoc: DocumentSnapshot?
    ) async -> (events: [Event], newLastDoc: DocumentSnapshot?, isEndReached: Bool) {
        do {
            var query = isMy
            ? getMyEventsCollection(userID: userID).order(by: "date", descending: false)
            : getSubscriptionsCollection(userID: userID).order(by: "date", descending: false)
            if let lastDoc {
                query = query.start(afterDocument: lastDoc)
            }
            query = query.limit(to: 3)

            let snapshot = try await query.getDocuments()
            let newEvents = try snapshot.documents.compactMap { try $0.data(as: Event.self) }
            let newLastDoc = snapshot.documents.last
            let isEndReached = newEvents.isEmpty

            return (newEvents, newLastDoc, isEndReached)
        } catch {
            if lastDoc != nil {
                Logger.Events.initialMyEventsLoadFail(error)
            } else {
                Logger.Events.nextPackMyEventsLoadFail(error)
            }

            return ([], lastDoc, true)
        }
    }

    func getMyEventsIDs(userID: String) async -> [String] {
        await fetchMyEventsIDs(userID: userID)
        return myEventsIDsTempStorage
    }

    private func fetchMyEventsIDs(userID: String) async {
        do {
            let myEventsCollection = getMyEventsCollection(userID: userID)
            let snapshot = try await myEventsCollection.getDocuments()
            let myEvents = try snapshot.documents.compactMap { try $0.data(as: Event.self) }
            myEventsIDsTempStorage = myEvents.map { $0.id }
        } catch {
            Logger.Events.errorGettingDocument(error)
        }
    }

}

// MARK: - Feed

extension DatabaseService {

    func loadFeed(lastDoc: DocumentSnapshot?) async -> (events: [Event], newLastDoc: DocumentSnapshot?, isEndReached: Bool) {
        do {
            var query = getFeedCollection().order(by: "date", descending: false)
            if let lastDoc {
                query = query.start(afterDocument: lastDoc)
            }
            query = query.limit(to: 3)

            let snapshot = try await query.getDocuments()
            let newEvents = try snapshot.documents.compactMap { try $0.data(as: Event.self) }
            let newLastDoc = snapshot.documents.last
            let isEndReached = newEvents.isEmpty

            return (newEvents, newLastDoc, isEndReached)
        } catch {
            if lastDoc != nil {
                Logger.Feed.initialFeedLoadFail(error)
            } else {
                Logger.Feed.nextPackFeedLoadFail(error)
            }

            return ([], lastDoc, true)
        }
    }

}


// MARK: - BuildEvent

extension DatabaseService {

    func addEventFor(userID: String, event: Event) {
        getEventInFeed(eventID: event.id).setData(event.representation)
        getEventInMyEvents(userID: userID, eventID: event.id).setData(event.representation)
    }

    func editEventFor(userID: String, event: Event) async -> Bool {
        let eventInFeed = getEventInFeed(eventID: event.id)
        let eventInMyEvents = getEventInMyEvents(userID: userID, eventID: event.id)

        do {
            try await eventInFeed.updateData(event.representation)
            try await eventInMyEvents.updateData(event.representation)

            Logger.BuildEvent.eventEditSuccess()
            return true
        } catch {
            Logger.BuildEvent.eventEditFail(error)
            return false
        }
    }

    func deleteEventFor(userID: String, event: Event) async -> Bool {
        let eventInFeed = getEventInFeed(eventID: event.id)
        let eventInMyEvents = getEventInMyEvents(userID: userID, eventID: event.id)

        do {
            try await eventInFeed.delete()
            try await eventInMyEvents.delete()

            Logger.BuildEvent.eventDeleteSuccess()
            return true
        } catch {
            Logger.BuildEvent.eventDeleteFail(error)
            return false
        }
    }

}
