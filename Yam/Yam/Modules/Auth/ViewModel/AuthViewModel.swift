import SwiftUI

final class AuthViewModel: ObservableObject {

    enum Field {
        case email
        case password
    }

    private let authService = AuthService.shared
    private let app = UIApplication.shared
    private var navManager: NavigationManager

    init(navManager: NavigationManager) {
        self.navManager = navManager
    }

    @Published var email = ""
    @Published var password = ""

    @Published var isActiveSignUpFailAlert = false
    @Published var isActiveSignInFailAlert = false

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
                case .success(_):
                    self?.clearTextFields()
                    self?.navManager.goToAuthorizedEntry()
                    Logger.Auth.userCreated()
                case .failure(let error):
                    self?.isActiveSignUpFailAlert.toggle()
                    Logger.Auth.userNotCreated(error: error)
                }
            }
        } else {
            authService.signIn(email: email, password: password) { [weak self] result in
                switch result {
                case .success(_):
                    self?.clearTextFields()
                    self?.navManager.goToAuthorizedEntry()
                    Logger.Auth.authSuccess()
                case .failure(let error):
                    self?.isActiveSignInFailAlert.toggle()
                    Logger.Auth.authFail(error: error)
                }
            }
        }
    }

    private func isCurrentUserAuthorized() -> Bool {
        authService.isCurrentUserAuthorized()
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

// MARK: - Support

extension AuthViewModel {

    func getNextFocusedField(from nowFocusedField: AuthField?) -> AuthField? {
        guard let nowFocusedField else { return nil }

        switch nowFocusedField {
        case .email:
            return AuthField.password
        default:
            return nil
        }
    }

    func hideKeyboard() {
        app.endEditing()
    }

}
