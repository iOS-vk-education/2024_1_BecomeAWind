import SwiftUI
import MapKit
import GeoFireUtils
import FirebaseFirestore

final class MapViewModel: NSObject, ObservableObject {

    private let dbService = DatabaseService.shared
    @Published var mapEvents = Set<Event>()

    private let locationManager = CLLocationManager()
    @State var position: MapCameraPosition = .userLocation(fallback: .automatic)
    private var lastUserLocation: CLLocationCoordinate2D?
    @Published var userLocation: CLLocationCoordinate2D? {
        didSet {
            guard let newLocation = userLocation else { return }

            if let lastUserLocation {
                let lastLoc = CLLocation(latitude: lastUserLocation.latitude, longitude: lastUserLocation.longitude)
                let newLoc = CLLocation(latitude: newLocation.latitude, longitude: newLocation.longitude)

                if lastLoc.distance(from: newLoc) < 500 { return }
            }

            lastUserLocation = newLocation
            Task {
                await loadEvents(at: newLocation)
            }
        }
    }

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }

}

// MARK: - Events loading

extension MapViewModel {

    func loadEvents(at userLocation: CLLocationCoordinate2D) async {
        do {
            let radiusInM: Double = 50 * 1000 // 50 км

            // формирую баундсы для создания массива кверис - чем больше радиус, тем бльше квадратов и кверис
            let queryBounds = GFUtils.queryBounds(forLocation: userLocation, withRadius: radiusInM)

            // формирую массив кверис на основе баундсов
            let queries = dbService.getQueries(from: queryBounds)

            // группа асинк задач, каждая из которых может выбросить ошибку и каждая возвращает массив QueryDocumentSnapshot
            let matchingEvents = try await withThrowingTaskGroup(of: [QueryDocumentSnapshot].self) { [weak self] group -> [QueryDocumentSnapshot] in
                guard let self else { return [] }

                // закидываю в группу таски, но не выполняю их
                for query in queries {
                    group.addTask {
                        try await self.dbService.fetchMatchingEvents(from: query,
                                                            userLocation: userLocation,
                                                            radiusInM: radiusInM)
                    }
                }

                var result = [QueryDocumentSnapshot]()

                // выполняю каждую таску из группы
                for try await documents in group {
                    result.append(contentsOf: documents)
                }

                return result
            }

            for now in matchingEvents {
                let event = try now.data(as: Event.self)
                mapEvents.insert(event)
            }
        } catch {
            Logger.Map.loadEventsFail(error)
        }
    }

}

// MARK: - Location manager

extension MapViewModel: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.last?.coordinate
    }

}
