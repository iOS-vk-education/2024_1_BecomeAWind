import Foundation

final class InfoViewModel: ObservableObject {

    let navManager: NavigationManager
    private let authInteractor = AuthInteractor.shared

    @Published var userEmail = ""

    @Published var isActiveSignOutFailAlert = false

    init(navManager: NavigationManager) {
        self.navManager = navManager
    }

}

// MARK: - Email

extension InfoViewModel {

    func getUserEmail() {
        guard let user = authInteractor.currentUser,
              let email = user.email else { return }

        userEmail = "почта: \(email)"
    }

    func getSearchRadius() -> String {
        return "радиус поиска ивентов на карте:\n500 км вокруг твоей локации"
    }

}

// MARK: - Sign out

extension InfoViewModel {

    func signOut() {
        authInteractor.signOut { [weak self] result in
            switch result {
            case .success(_):
                self?.navManager.backToRoot()
                
                Logger.Auth.signOutSuccess()
            case .failure(let error):
                self?.isActiveSignOutFailAlert = true

                Logger.Auth.signOutFail(error: error)
            }
        }
    }

}
