import SwiftUI

final class AuthViewModel: ObservableObject {

    private let authService = AuthService.shared

    @Published var email = ""
    @Published var password = ""

    @Published var isActiveSignUpFailAlert = false
    @Published var isActiveSignInFailAlert = false
    @Published var isActiveEntry = false

    /// nav bar
    @Published var activeTab: AuthTab = .signIn
    var leftTab: AuthTab = .signIn
    var rightTab: AuthTab = .signUp
    var isVisibleCenterButton = false

}

// MARK: - Auth

extension AuthViewModel {

    func auth() {
        if activeTab == .signUp {
            authService.signUp(email: email, password: password) { [weak self] result in
                switch result {
                case .success(let user):
                    self?.clearTextFields()
                    self?.isActiveEntry.toggle()
                    Logger.Auth.userCreated()
                case .failure(let error):
                    self?.isActiveSignUpFailAlert.toggle()
                    Logger.Auth.userNotCreated(error: error)
                }
            }
        } else {
            authService.signIn(email: email, password: password) { [weak self] result in
                switch result {
                case .success(let user):
                    self?.clearTextFields()
                    self?.isActiveEntry.toggle()
                    Logger.Auth.authSuccess()
                case .failure(let error):
                    self?.isActiveSignInFailAlert.toggle()
                    Logger.Auth.authFail(error: error)
                }
            }
        }
    }

    private func clearTextFields() {
        email = ""
        password = ""
    }

}


// MARK: - NavBarViewModelProtocol

extension AuthViewModel: NavBarViewModelProtocol {

    func changeActiveTabTo(_ tab: AuthTab) {
        activeTab = tab
    }

    func centerButtonAction() {}

}
