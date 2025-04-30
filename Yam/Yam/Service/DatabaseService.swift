import Foundation
import FirebaseFirestore

final class DatabaseService {

    static let shared = DatabaseService()
    private let db = Firestore.firestore()

    private var myEventsIDsTempStorage = [String]()
    private var subscriptionsIDsTempStorage = [String]()

    private init() {}

    ///
    private func getUserDoc(userID: String) -> DocumentReference {
        db.collection("users").document(userID)
    }

    ///
    private func getFeedCollection() -> CollectionReference {
        db.collection("feed")
    }

    private func getEventInFeed(eventID: String) -> DocumentReference {
        getFeedCollection().document(eventID)
    }

    ///
    private func getEventInMyEvents(userID: String, eventID: String) -> DocumentReference {
        let myEventsCollection = getUserDoc(userID: userID).collection("myEvents")
        return myEventsCollection.document(eventID)
    }

    ///
    private func getEventInSubscriptions(userID: String, eventID: String) -> DocumentReference {
        let subscriptionsCollection = getUserDoc(userID: userID).collection("subscriptions")
        return subscriptionsCollection.document(eventID)
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

//    func loadEvents(
//        of type: EventType,
//        for userID: String,
//        lastDoc: DocumentSnapshot?
//    ) async -> (events: [Event], newLastDoc: DocumentSnapshot?, isEndReached: Bool) {
//        do {
//            var query = try await getUserDoc(userID: userID).
//        } catch {
//
//        }
//    }

    func getEvents(my: Bool, userID: String) async -> [Event] {
        var events = [Event]()

        do {
            let userDoc = try await getUserDoc(userID: userID).getDocument()

            if userDoc.exists {
                let user = try userDoc.data(as: YUser.self)

                if my {
                    events = user.myEvents
                    myEventsIDsTempStorage = getEventsIDs(events)
                } else {
                    events = user.subscriptions
                    subscriptionsIDsTempStorage = getEventsIDs(events)
                }
            } else {
                Logger.Events.docDoesntExist()
            }
        } catch {
            Logger.Events.errorGettingDocument(error)
        }

        return events
    }

    private func getEventsIDs(_ events: [Event]) -> [String] {
        var res = [String]()

        for now in events {
            res.append(now.id)
        }

        return res
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
                Logger.Feed.initialEventsLoadFail(error)
            } else {
                Logger.Feed.nextPackEventsLoadFail(error)
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
