import Foundation

final class EventsModel: ObservableObject {

    private let dbService = DatabaseService.shared

}

extension EventsModel {

    func getEvents(of type: EventsTab) -> [Event] {
        return []
    }

}
