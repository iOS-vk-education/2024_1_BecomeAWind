import Foundation
import FirebaseFirestore
import MapKit
import GeoFireUtils

final class Delme {

    let db = Firestore.firestore()
    var mapEvents = [Event]()
    let userLocation = CLLocationCoordinate2D(latitude: 62.4875, longitude: -45.5853)
    let radiusInM: Double = 50 * 10000 // 500 км

    init() {
        Task {
//            await loadEvents(userLocation: CLLocation(latitude: 52.3651, longitude: 4.9044))
            // центр Амстердама

            await loadEvents()
        }
    }

    func loadEventsFromGeopoint(userLocation: CLLocation) async {
        do {
            let userLatitude = userLocation.coordinate.latitude
            let userLongitude = userLocation.coordinate.longitude

            let minGeoPoint = GeoPoint(latitude: userLatitude - 2.0, longitude: userLongitude - 2.0)
            let maxGeoPoint = GeoPoint(latitude: userLatitude + 2.0, longitude: userLongitude + 2.0)

            let feedRef = try await db.collection("feed")
                .whereField("place.geopoint", isGreaterThan: minGeoPoint)
                .whereField("place.geopoint", isLessThan: maxGeoPoint)
                .getDocuments()

            let events = try feedRef.documents.map { try $0.data(as: Event.self) }

            for now in events {
                print(now.id)
            }
        } catch {
            Logger.ping()
        }
    }

}

extension Delme {

    @Sendable func fetchMatchingEvents(from query: Query,
                             userLocation: CLLocationCoordinate2D,
                             radiusInM: Double) async throws -> [QueryDocumentSnapshot] {
        let snapshot = try await query.getDocuments()

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
                return false
            }

        }
    }

    func loadEvents() async {
        do {
            let queryBounds = GFUtils.queryBounds(forLocation: userLocation, withRadius: radiusInM)
            let queries = queryBounds.map { bound -> Query in
                return db.collection("feed")
                    .order(by: "place.geohash")
                    .start(at: [bound.startValue])
                    .end(at: [bound.endValue])
            }

            let matchingEvents = try await withThrowingTaskGroup(of: [QueryDocumentSnapshot].self) { [weak self] group -> [QueryDocumentSnapshot] in
                guard let self else { return [] }

                for query in queries {
                    group.addTask {
                        try await self.fetchMatchingEvents(from: query,
                                                      userLocation: self.userLocation,
                                                      radiusInM: self.radiusInM)
                    }
                }

                var result = [QueryDocumentSnapshot]()
                for try await documents in group {
                    result.append(contentsOf: documents)
                }

                print(result.count)
                return result
            }

//            for now in matchingEvents {
//                let event = try now.data(as: Event.self)
//                print(event.id)
//            }
        } catch {
            Logger.ping()
        }
    }

}
