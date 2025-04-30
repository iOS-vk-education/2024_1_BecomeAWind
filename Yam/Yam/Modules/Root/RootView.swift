import SwiftUI

struct RootView: View {

    @StateObject private var navManager = NavigationManager()

    private let delme = DelmeViewModel()

    var body: some View {
        if !navManager.isUserAuthorized {
            AuthView(viewModel: makeAuthViewModel())
        } else {
            AuthorizedEntryView(viewModel: makeAuthorizedEntryViewModel())
        }
    }

}

extension RootView {
    
    func makeAuthorizedEntryViewModel() -> AuthorizedEntryViewModel {
        AuthorizedEntryViewModel(navManager: navManager)
    }

    func makeAuthViewModel() -> AuthViewModel {
        AuthViewModel(navManager: navManager)
    }

}

#Preview {
    RootView()
}
