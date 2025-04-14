import SwiftUI
import MapKit

struct AuthView: View {

    @StateObject private var viewModel = AuthViewModel()

    var body: some View {
        NavBar(viewModel: viewModel) {
            ZStack {
                Map(interactionModes: [])
                    Color.black
                    .opacity(0.5)
                    .ignoresSafeArea()

                ThinMaterialVStack {
                    EmailView(viewModel: viewModel)
                    PasswordView(viewModel: viewModel)

                    Button {

                    } label: {
                        YCapsuleLabel(
                            title: viewModel.activeTab == .signIn ? "войти" : "создать аккаунт",
                            font: Const.buttonFont
                        )
                    }
                }
            }
        }
    }

}

#Preview {
    AuthView()
}
