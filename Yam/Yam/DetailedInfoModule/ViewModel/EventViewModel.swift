import SwiftUI

final class EventViewModel: ObservableObject {
    private var mockData = EventsMock()

    @Published var events: [Event2] = []

    init() {
        getEvents()
    }

    func getEvents() {
        events = mockData.getEvents()
    }
}
