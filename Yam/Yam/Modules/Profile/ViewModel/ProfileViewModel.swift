import SwiftUI

final class ProfileViewModel: ObservableObject {
    @Published var isActiveCreateEvent = false

    func toggleCreateEvent() {
        isActiveCreateEvent.toggle()
    }
}
