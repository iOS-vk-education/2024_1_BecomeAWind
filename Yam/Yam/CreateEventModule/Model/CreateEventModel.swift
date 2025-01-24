import SwiftUI

final class CreateEventModel: ObservableObject {
    @ObservedObject var temp = TempDatabase.shared

    func createEvent(_ event: Event) {
        temp.events.append(event)
        print(temp.events.count)
    }
}
