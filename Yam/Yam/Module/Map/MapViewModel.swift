import SwiftUI
import MapKit
import GeoFireUtils
import FirebaseFirestore
import ClusterMap

@Observable
final class MapViewModel: NSObject, ObservableObject {

    private let dbService = DatabaseService.shared
    private let authInteractor = AuthInteractor.shared
    private var navManager: NavigationManager

    var mapEvents = [Event]()

    // Map clustering
    private let clusterManager = ClusterManager<MapAnnotation>()
    var mapSize: CGSize = .zero
    var region: MKCoordinateRegion = .init()
    var annotations = [MapAnnotation]()
    var clusters = [MapCluster]()

    // Location manager
    private let locationManager = CLLocationManager()
    var position: MapCameraPosition = .userLocation(fallback: .automatic)
    private var lastUserLocation: CLLocationCoordinate2D?
    var userLocation: CLLocationCoordinate2D? {
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

    var isLocationServicesEnabled = false
    var authStatus: LocationAuthStatus = .notDetermined
    var opacityOfOpenSettingsView: Double = 0

    // EventsAccordion
    var currentEventPack = [Event]()
    var isActiveEventsAccordion = false

    // Modules
    var isActiveEvents = false
    var isActiveProfile = false

    init(navManager: NavigationManager) {
        self.navManager = navManager

        super.init()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }

}

// MARK: - Support

extension MapViewModel {

    func centerMapOnUserLocation() {
        withAnimation {
            position = .userLocation(fallback: .automatic)
        }
    }

    func openSettings() {
        if let appSettings = URL(
            string: UIApplication.openSettingsURLString
        ) {
            UIApplication.shared.open(appSettings)
        }
    }

    func getEventsCount() -> String {
        EventHandler.getEventsCountString(mapEvents.count)
    }

    private func getEventIDs() async {
        guard let userID = authInteractor.getUserID() else { return }

        await dbService.getEventIDs(userID: userID, my: true)
        await dbService.getEventIDs(userID: userID, my: false)
    }

}

// MARK: - Events

extension MapViewModel {

    @MainActor
    func openEvents() {
        isActiveEvents = true
    }

    func makeEventsView() -> EventsView {
        let vm = EventsViewModel()
        let view = EventsView(viewModel: vm)
        return view
    }

}

// MARK: - Profile

extension MapViewModel {

    @MainActor
    func openProfile() {
        isActiveProfile = true
    }

    func makeProfileView() -> ProfileView {
        let vm = ProfileViewModel(navManager: navManager)
        let view = ProfileView(viewModel: vm)
        return view
    }

}

// MARK: - EventsAccordion

extension MapViewModel {

    func showEventsAccordion(eventPack: [Event]) async {
        await getEventIDs()

        currentEventPack = eventPack
        isActiveEventsAccordion = true
    }

    func makeEventsAccordionView(eventPack: [Event]) -> EventsAccordionView {
        let vm = EventsAccordionViewModel(eventPack: eventPack)
        let view = EventsAccordionView(viewModel: vm)
        return view
    }

}

// MARK: - Events loading

extension MapViewModel {

    @MainActor
    func loadEvents(at userLocation: CLLocationCoordinate2D?) async {
        guard let loc = userLocation else { return }

        do {
            let radiusInM: Double = 50 * 10000 // 50 км

            // формирую баундсы для создания массива кверис - чем больше радиус, тем бльше квадратов и кверис
            let queryBounds = GFUtils.queryBounds(forLocation: loc, withRadius: radiusInM)

            // формирую массив кверис на основе баундсов
            let queries = dbService.getQueries(from: queryBounds)

            // группа асинк задач, каждая из которых может выбросить ошибку и каждая возвращает массив QueryDocumentSnapshot
            let matchingEvents = try await withThrowingTaskGroup(of: [QueryDocumentSnapshot].self) { [weak self] group -> [QueryDocumentSnapshot] in
                guard let self else { return [] }

                // закидываю в группу таски, но не выполняю их
                for query in queries {
                    group.addTask {
                        try await self.dbService.fetchMatchingEvents(from: query,
                                                            userLocation: loc,
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

            var newAnnotations = [MapAnnotation]()
            mapEvents.removeAll()

            for now in matchingEvents {
                let event = try now.data(as: Event.self)
                mapEvents.append(event)

                let coordinate = CLLocationCoordinate2D(latitude: event.place.geopoint.latitude,
                                                        longitude: event.place.geopoint.longitude)
                let annotation = MapAnnotation(event: event, coordinate: coordinate)
                newAnnotations.append(annotation)
            }

            await removeAnnotations()
            await addAnnotations(newAnnotations)
        } catch {
            Logger.Map.loadEventsFail(error)
        }
    }

}

// MARK: - Map clustering

extension MapViewModel {

    @MainActor
    func reloadAnnotations() async {
        async let changes = clusterManager.reload(mapViewSize: mapSize, coordinateRegion: region)
        await applyChanges(changes)
    }

    private func addAnnotations(_ annotations: [MapAnnotation]) async {
        await clusterManager.add(annotations)
        await reloadAnnotations()
    }

    private func removeAnnotations() async {
        await clusterManager.removeAll()
        await reloadAnnotations()
    }

    private func applyChanges(_ difference: ClusterManager<MapAnnotation>.Difference) {

        for removal in difference.removals {
            switch removal {
            case .annotation(let annotation):
                annotations.removeAll { $0 == annotation }
            case .cluster(let cluster):
                clusters.removeAll { $0.id == cluster.id }
            }
        }

        for insertion in difference.insertions {
            switch insertion {
            case .annotation(let newAnnotation):
                annotations.append(newAnnotation)
            case .cluster(let newCluster):
                clusters.append(MapCluster(
                    id: newCluster.id,
                    coordinate: newCluster.coordinate,
                    eventPack: newCluster.memberAnnotations.map { $0.event }
                ))
            }
        }

    }

}

// MARK: - Location manager

extension MapViewModel: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.last?.coordinate
    }

    /*  Функция locationManagerDidChangeAuthorization(_ manager: CLLocationManager) принадлежит делегату CLLocationManagerDelegate. Она вызывается каждый раз когда создается объект класса CLLocationManager и когда меняется статус авторизации служб геолокации.
     https://developer.apple.com/documentation/corelocation/cllocationmanagerdelegate/locationmanagerdidchangeauthorization(_:)
     */
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorizationStatus()
    }

    private func checkLocationAuthorizationStatus() {
        authStatus = .notDetermined

        switch locationManager.authorizationStatus {
        case .notDetermined:
            authStatus = .notDetermined
            opacityOfOpenSettingsView = 0
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            authStatus = .access
            opacityOfOpenSettingsView = 0
            isLocationServicesEnabled = true
        default:
            authStatus = .restricted
            opacityOfOpenSettingsView = 1
            isLocationServicesEnabled = false
        }
    }

}

