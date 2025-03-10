import SwiftUI

final class ProfileViewModel: ObservableObject {

    @ObservedObject var db = TempDatabase.shared

    /// top tab bar
    @Published var isActiveCreateEvent = false
    @Published var activeTab: ProfileTab = .myEvents

    /// event card
    @Published var invalidLink = false


    func toggleCreateEvent() {
        isActiveCreateEvent.toggle()
    }

}

/// top tab bar
extension ProfileViewModel {

    func changeActiveTabTo(_ tab: ProfileTab) {
        activeTab = tab
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
