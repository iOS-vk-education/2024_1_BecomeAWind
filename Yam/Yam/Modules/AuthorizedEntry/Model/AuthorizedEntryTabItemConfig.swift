import Foundation

struct AuthorizedEntryTabItemConfig: Identifiable {
    let id = UUID()
    var tab: AuthorizedEntryTab
    var title: String
    var imageName: String
}
