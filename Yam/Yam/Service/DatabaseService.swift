import Foundation
import FirebaseFirestore

final class DatabaseService {

    static let shared = DatabaseService()
    private let db = Firestore.firestore()

    private var usersReference: CollectionReference {
        db.collection("users")
    }

    private init() {}
    
}

// MARK: - Auth

extension DatabaseService {

    func createUser(user: YUser, completion: @escaping (Result<YUser, Error>) -> Void) {
        usersReference.document(user.id).setData(user.representation) { error in
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

    func getEvents(of type: EventType, from userID: String) async -> (myEvents: [Event], subscriptions: [Event]) {
        var myEvents = [Event](), subscriptions = [Event]()
        let userRef = usersReference.document(userID)

        do {
            let userDoc = try await userRef.getDocument()

            if userDoc.exists {
                let user = try userDoc.data(as: YUser.self)
                myEvents = user.myEvents
                subscriptions = user.subscriptions
            } else {
                Logger.Events.docDoesntExist()
            }
        } catch {
            Logger.Events.errorGettingDocument(error)
        }

        return (myEvents, subscriptions)
    }

}


// MARK: - BuildEvent

extension DatabaseService {

    func addEventFor(userID: String, event: Event) {
        let userDocument = usersReference.document(userID)

        userDocument.updateData([
            "myEvents": FieldValue.arrayUnion([event.representation])
        ])
    }

}
