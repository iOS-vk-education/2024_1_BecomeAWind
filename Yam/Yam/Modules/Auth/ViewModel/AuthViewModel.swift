import SwiftUI

final class AuthViewModel: ObservableObject, NavBarViewModelProtocol {

    @Published var username = ""
    @Published var email = ""
    @Published var password = ""

    /// nav bar
    @Published var activeTab: AuthTab = .login
    var leftTab: AuthTab = .login
    var rightTab: AuthTab = .signin

}

extension AuthViewModel {

    func changeActiveTabTo(_ tab: AuthTab) {
        activeTab = tab
    }

    func centerButtonAction() {
        // some action soon from ilyansky
    }

}
