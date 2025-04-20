import Foundation
import SwiftUI

final class NavigationManager: ObservableObject {

    private let authService = AuthService.shared
    @Published var isUserAuthorized: Bool 

    init() {
        isUserAuthorized = authService.isCurrentUserAuthorized()
    }

    func goToAuthorizedEntry() {
        isUserAuthorized = true
    }

    func backToRoot() {
        isUserAuthorized = false
    }

}
