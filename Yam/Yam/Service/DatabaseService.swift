import Foundation
import FirebaseFirestore

final class DatabaseService {

    static let shared = DatabaseService()
    private let db = Firestore.firestore()

    var myEventsIDsTempStorage = [String]()

    private init() {}

    ///
    private func getUsersCollection() -> CollectionReference {
        db.collection("users")
    }

    private func getUserRef(userID: String) -> DocumentReference {
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
        getUserRef(userID: userID).collection("myEvents")
    }

    private func getSubscriptionsCollection(userID: String) -> CollectionReference {
        getUserRef(userID: userID).collection("subscriptions")
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
        getUserRef(userID: user.id).setData(user.representation) { error in
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
            query = query.limit(to: 25)

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

}

// MARK: - Feed

extension DatabaseService {

    func loadFeed(lastDoc: DocumentSnapshot?) async -> (events: [Event], newLastDoc: DocumentSnapshot?, isEndReached: Bool) {
        do {
            var query = getFeedCollection().order(by: "date", descending: false)
            if let lastDoc {
                query = query.start(afterDocument: lastDoc)
            }
            query = query.limit(to: 25)

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

    func getMyEventsIDs(userID: String) async -> [String] {
        var res = [String]()

        do {
            let user = try await getUserRef(userID: userID).getDocument(as: YUser.self)
            res = user.myEventsIDs
        } catch {
            Logger.Feed.getMyEventsIDsFail(error)
        }

        return res
    }

}


// MARK: - BuildEvent

extension DatabaseService {

    func addEventFor(userID: String, event: Event) {
        getEventInFeed(eventID: event.id).setData(event.representation)
        getEventInMyEvents(userID: userID, eventID: event.id).setData(event.representation)

        getUserRef(userID: userID).updateData([
            "myEventsIDs": FieldValue.arrayUnion([event.id])
        ])
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
        do {
            try await getEventInFeed(eventID: event.id).delete()
            try await getEventInMyEvents(userID: userID, eventID: event.id).delete()

            try await getUserRef(userID: userID).updateData([
                "myEventsIDs": FieldValue.arrayRemove([event.id])
            ])

            Logger.BuildEvent.eventDeleteSuccess()
            return true
        } catch {
            Logger.BuildEvent.eventDeleteFail(error)
            return false
        }
    }

}
