import Foundation
import SwiftUI

final class NavigationManager: ObservableObject {

    private let authInteractor = AuthInteractor.shared
    @Published var isUserAuthorized: Bool

    init() {
        isUserAuthorized = authInteractor.isCurrentUserAuthorized()
    }

    func goToAuthorizedEntry() {
        isUserAuthorized = true
    }

    func backToRoot() {
        isUserAuthorized = false
    }

}
