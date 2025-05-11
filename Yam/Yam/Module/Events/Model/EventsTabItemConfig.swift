import Foundation

struct EventsTabItemConfig: Identifiable {
    let id = UUID()

    var tab: EventsTab
    var title: String
    var imageName: String
}
