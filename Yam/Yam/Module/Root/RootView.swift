import SwiftUI

struct RootView: View {

    @StateObject private var navManager = NavigationManager()

    var body: some View {
        if !navManager.isUserAuthorized {
            makeAuthView()
        } else {
            makeMapView()
        }
    }

}

extension RootView {

    func makeAuthView() -> AuthView {
        let vm = AuthViewModel(navManager: navManager)
        let view = AuthView(viewModel: vm)
        return view
    }

    func makeMapView() -> MapView {
        let vm = MapViewModel(navManager: navManager)
        let view = MapView(viewModel: vm)
        return view
    }

}

#Preview {
    RootView()
}
