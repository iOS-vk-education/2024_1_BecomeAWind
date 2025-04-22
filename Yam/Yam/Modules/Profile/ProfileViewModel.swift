import Foundation

final class ProfileViewModel: ObservableObject {

    let navManager: NavigationManager
    private let authInteractor = AuthInteractor.shared

    @Published var isActiveSignOutFailAlert = false

    init(navManager: NavigationManager) {
        self.navManager = navManager
    }

}

extension ProfileViewModel {

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
