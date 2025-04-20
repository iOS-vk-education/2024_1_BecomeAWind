import SwiftUI

struct RootView: View {

    @StateObject private var navManager = NavigationManager()

    var body: some View {
        if !navManager.isUserAuthorized {
            Text("Not auth")
            Button {
                navManager.goToAuthorizedEntry()
            } label: {
                Text("log in")
            }
//            AuthorizedEntryView(viewModel: viewModel.makeAuthorizedEntryViewModel())
        } else {
//            AuthView(viewModel: viewModel.makeAuthViewModel())
            Button {
                navManager.backToRoot()
            } label: {
                Text("log out")
            }
        }
    }

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
