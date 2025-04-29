import Foundation
import FirebaseFirestore

final class DatabaseService {

    static let shared = DatabaseService()
    private let db = Firestore.firestore()

    private var myEventsIDsTempStorage = [String]()

    private init() {}

    private func getUserDoc(userID: String) -> DocumentReference {
        db.collection("users").document(userID)
    }

    private func getEventDoc(eventID: String) -> DocumentReference {
        db.collection("allEvents").document(eventID)
    }

    private func getEventsCollection() -> CollectionReference {
        db.collection("allEvents")
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

    func getEvents(of type: EventType, userID: String) async -> [Event] {
        var events = [Event]()

        do {
            let userDoc = try await getUserDoc(userID: userID).getDocument()

            if userDoc.exists {
                let user = try userDoc.data(as: YUser.self)

                if type == .my {
                    events = user.myEvents
                    myEventsIDsTempStorage = getEventsIDs(events)
                } else {
                    events = user.subscriptions
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

    func getAllEvents() async -> [Event] {
        var events = [Event]()

        do {
            let allEvents = try await getEventsCollection().getDocuments()

            for nowEvent in allEvents.documents {
                let event = try nowEvent.data(as: Event.self)
                if !myEventsIDsTempStorage.contains(event.id) {
                    events.append(event)
                }
            }
            Logger.Feed.getEventsSuccess()
        } catch {
            Logger.Feed.getEventsFail(error)
        }
        
        return events
    }

}


// MARK: - BuildEvent

extension DatabaseService {

    func addEventFor(userID: String, event: Event) {
        getEventDoc(eventID: event.id).setData(event.representation)
        getUserDoc(userID: userID).updateData([
            "myEvents": FieldValue.arrayUnion([event.representation])
        ])
    }

    func editEventFor(userID: String, event: Event) async -> Bool {
        let userDoc = getUserDoc(userID: userID)
        let eventDoc = getEventDoc(eventID: event.id)

        var myEvents = await getEvents(of: .my, userID: userID)

        let indexToRemove = findIndexToRemove(in: myEvents, with: event.id)
        if let indexToRemove {
            myEvents.remove(at: indexToRemove)
            myEvents.insert(event, at: indexToRemove)
        }


        do {
            try await userDoc.updateData([
                "myEvents": myEvents.map { $0.representation }
            ])
            try await eventDoc.updateData(event.representation)
            Logger.BuildEvent.eventEditSuccess()
            return true
        } catch {
            Logger.BuildEvent.eventEditFail(error)
            return false
        }
    }

    func deleteEventFor(userID: String, event: Event) async -> Bool {
        let userDoc = getUserDoc(userID: userID)
        let eventDoc = getEventDoc(eventID: event.id)

        var myEvents = await getEvents(of: .my, userID: userID)

        let indexToRemove = findIndexToRemove(in: myEvents, with: event.id)
        if let indexToRemove {
            myEvents.remove(at: indexToRemove)
        }

        do {
            try await userDoc.updateData([
                "myEvents": myEvents.map { $0.representation }
            ])
            try await eventDoc.delete()
            Logger.BuildEvent.eventDeleteSuccess()
            return true
        } catch {
            Logger.BuildEvent.eventDeleteFail(error)
            return false
        }
    }

    private func findIndexToRemove(in eventArray: [Event], with id: String) -> Int? {
        for (i, now) in eventArray.enumerated() {
            if now.id == id {
                return i
            }
        }
        return nil
    }

}
