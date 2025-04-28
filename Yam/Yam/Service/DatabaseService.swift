import Foundation
import FirebaseFirestore

final class DatabaseService {

    static let shared = DatabaseService()
    private let db = Firestore.firestore()

    private init() {}

    private func getUserDoc(userID: String) -> DocumentReference {
        db.collection("users").document(userID)
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
                events = type == .my ? user.myEvents : user.subscriptions
            } else {
                Logger.Events.docDoesntExist()
            }
        } catch {
            Logger.Events.errorGettingDocument(error)
        }

        return events
    }

}


// MARK: - BuildEvent

extension DatabaseService {

    func addEventFor(userID: String, event: Event) {
        getUserDoc(userID: userID).updateData([
            "myEvents": FieldValue.arrayUnion([event.representation])
        ])
    }

    func editEventFor(userID: String, event: Event) async {
        func findIndexToRemove() -> Int? {
            for (i, now) in myEvents.enumerated() {
                if now.id == event.id {
                    return i
                }
            }
            return nil
        }

        let userDoc = getUserDoc(userID: userID)

        var myEvents = await getEvents(of: .my, userID: userID)

        let indexToRemove = findIndexToRemove()
        if let indexToRemove {
            myEvents.remove(at: indexToRemove)
            myEvents.insert(event, at: indexToRemove)
        }


        do {
            try await userDoc.updateData([
                "myEvents": myEvents.map { $0.representation }
            ])
            Logger.BuildEvent.eventEditSuccess()
        } catch {
            Logger.BuildEvent.eventEditFail(error)
        }
    }

}
