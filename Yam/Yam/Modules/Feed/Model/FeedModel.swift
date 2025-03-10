import Foundation
import SwiftUI

final class FeedModel: ObservableObject {
    @Published var tempDatabase = TempDatabase.shared

    var events: [Event] {
        tempDatabase.myEvents
    }
}
