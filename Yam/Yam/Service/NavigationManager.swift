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
        print(#function)
    }

    func backToRoot() {
        isUserAuthorized = false
        print(#function)
    }

}
