import SwiftUI

struct RootView: View {

    @StateObject private var navManager = NavigationManager()

    var body: some View {
        if !navManager.isUserAuthorized {
            makeAuthView()
        } else {
            makeMapSwitcherView()
        }
    }

}

extension RootView {

    func makeAuthView() -> AuthView {
        let vm = AuthViewModel(navManager: navManager)
        let view = AuthView(viewModel: vm)
        return view
    }

    func makeMapSwitcherView() -> MapSwitcherView {
        let vm = MapViewModel(navManager: navManager)
        let view = MapSwitcherView(viewModel: vm)
        return view
    }

}

#Preview {
    RootView()
}
