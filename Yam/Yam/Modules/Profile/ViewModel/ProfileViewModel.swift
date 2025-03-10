import SwiftUI

final class ProfileViewModel: ObservableObject {

    @ObservedObject var db = TempDatabase.shared
    @Published var isActiveCreateEvent = false

    /// event card
    @Published var invalidLink = false


    func toggleCreateEvent() {
        isActiveCreateEvent.toggle()
    }

}

/// event card
extension ProfileViewModel {

    func openLink(_ link: String) {
        if let url = URL(string: link) {
            UIApplication.shared.open(url)
        } else {
            invalidLink.toggle()
        }
    }
}
