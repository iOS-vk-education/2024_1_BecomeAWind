import SwiftUI
import MapKit
import GeoFireUtils
import FirebaseFirestore

final class MapViewModel: ObservableObject {

    private let dbService = DatabaseService.shared

    @State var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var isActiveDetailedInfoView = false
    @State private var selectedEvent: UIEvent?

    @Published var mapEvents: [Event] = []

    init() {
        Task {
            await loadEvents()
        }
    }

}

extension MapViewModel {

    func loadEvents() async {
        do {
            let userLocation = CLLocationCoordinate2D(latitude: 52.0496, longitude: 5.2405)
            let radiusInM: Double = 50 * 10000 // 500 км

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
                                                            userLocation: CLLocationCoordinate2D(
                                                            latitude: 52.0496,
                                                            longitude: 5.2405),
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

//            for now in matchingEvents {
//                let event = try now.data(as: Event.self)
//                print(event.id)
//            }
        } catch {
            Logger.ping()
        }
    }

}
