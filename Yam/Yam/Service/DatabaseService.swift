import Foundation
import GeoFireUtils
import FirebaseFirestore
import SwiftUI
import CoreLocation

final class DatabaseService: ObservableObject {

    static let shared = DatabaseService()
    private let db = Firestore.firestore()

    @Published var myEventsIDs = Set<String>()
    @Published var subscriptionsIDs = Set<String>()

    private init() {}

}

// MARK: - References

extension DatabaseService {

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

// MARK: - Auth module

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

// MARK: - Events module

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

// MARK: - Feed module

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

}

// MARK: - Map module

extension DatabaseService {

    @Sendable func fetchMatchingEvents(from query: Query,
                             userLocation: CLLocationCoordinate2D,
                             radiusInM: Double) async throws -> [QueryDocumentSnapshot] {
        // кваждый квери - это геохеш квадрат
        let snapshot = try await query.getDocuments()

        // фильтрую все доки в снепшоте по дистанции от юзера до ивента
        // тк функция fetchMatchingEvents запускается многократно - происходит многократная фильтрация массивов доков в снепшотах
        return snapshot.documents.filter { eventSnapshot in
            
            do {
                let event = try eventSnapshot.data(as: Event.self)
                let geopoint = event.place.geopoint
                let lat = geopoint.latitude
                let lng = geopoint.longitude

                let eventLoc = CLLocation(latitude: lat, longitude: lng)
                let userLoc = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)

                let distance = userLoc.distance(from: eventLoc)

                return distance <= radiusInM
            } catch {
                Logger.Map.failedToFetchMatchingEvents(error)
                return false
            }

        }
    }

    // на входе массив кверис баундс - возвращаю массив кверис по массиву кверис баундс
    func getQueries(from queryBounds: [GFGeoQueryBounds]) -> [Query] {
        queryBounds.map { bound -> Query in
            return getFeedCollection()
                .order(by: "place.geohash")
                .start(at: [bound.startValue])
                .end(at: [bound.endValue])
        }
    }

}

// MARK: - Events manipulating

extension DatabaseService {

    func addEventFor(userID: String, event: Event) async -> Bool {
        do {
            try await getEventInFeed(eventID: event.id).setData(event.representation)
            try await getEventInMyEvents(userID: userID, eventID: event.id).setData(event.representation)

            try await getUserRef(userID: userID).updateData([
                "myEventsIDs": FieldValue.arrayUnion([event.id])
            ])
            Logger.BuildEvent.eventCreateSuccess(id: event.id)
            return true
        } catch {
            Logger.BuildEvent.eventCreateFail(error)
            return false
        }
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

    func subscribeToTheEvent(userID: String, event: Event) async -> Bool {
        do {
            try await getEventInSubscriptions(userID: userID, eventID: event.id).setData(event.representation)

            try await getEventInFeed(eventID: event.id).updateData([
                "seats.busy": event.seats.busy
            ])

            try await getUserRef(userID: userID).updateData([
                "subscriptionsIDs": FieldValue.arrayUnion([event.id])
            ])

            Logger.Feed.subscribeToTheEventSuccess()
            return true
        } catch {
            Logger.Feed.subscribeToTheEventFail(error)
            return false
        }
    }

    func unsubscribeToTheEvent(userID: String, event: Event) async -> Bool {
        do {
            try await getEventInSubscriptions(userID: userID, eventID: event.id).delete()

            try await getEventInFeed(eventID: event.id).updateData([
                "seats.busy": event.seats.busy
            ])

            try await getUserRef(userID: userID).updateData([
                "subscriptionsIDs": FieldValue.arrayRemove([event.id])
            ])

            Logger.Feed.unsubscribeToTheEventSuccess()
            return true
        } catch {
            Logger.Feed.unsubscribeToTheEventFail(error)
            return false
        }
    }

    func getEventsIDs(userID: String, my: Bool) async {
        do {
            let user = try await getUserRef(userID: userID).getDocument(as: YUser.self)

            if my {
                myEventsIDs = Set(user.myEventsIDs)
            } else {
                subscriptionsIDs = Set(user.subscriptionsIDs)
            }
        } catch {
            Logger.Feed.getEventsIDsFail(error)
        }
    }

    func getEvent(by eventID: String) async throws -> Event {
        let eventSnapshot = try await getFeedCollection().document(eventID).getDocument()
        return try eventSnapshot.data(as: Event.self)
    }

}
