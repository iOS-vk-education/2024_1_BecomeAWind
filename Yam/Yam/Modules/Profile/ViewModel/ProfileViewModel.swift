import SwiftUI

final class ProfileViewModel: ObservableObject {

    @ObservedObject var db = TempDatabase.shared
    @Published var isActiveCreateEvent = false


    func toggleCreateEvent() {
        isActiveCreateEvent.toggle()
    }

}
