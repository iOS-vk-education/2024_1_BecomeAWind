import SwiftUI

final class AuthViewModel: ObservableObject, NavBarViewModelProtocol {

    @Published var email = ""
    @Published var password = ""

    /// nav bar
    @Published var activeTab: AuthTab = .signIn
    var leftTab: AuthTab = .signIn
    var rightTab: AuthTab = .signUp
    var isVisibleCenterButton: Bool = false

}

extension AuthViewModel {

    func changeActiveTabTo(_ tab: AuthTab) {
        activeTab = tab
    }

    func centerButtonAction() {
        // some action soon from ilyansky
    }

}
