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
                    AuthButton(viewModel: viewModel)
                }
            }
        }
        .alert(
            AuthConst.singUpFailText,
            isPresented: $viewModel.isActiveSignUpFailAlert
        ) {
            Button("ок", role: .cancel) { }
        }
        .alert(
            AuthConst.singInFailText,
            isPresented: $viewModel.isActiveSignInFailAlert
        ) {
            Button("ок", role: .cancel) { }
        }
        .fullScreenCover(isPresented: $viewModel.isActiveEntry) {
            EntryView()
        }
    }

}

#Preview {
    AuthView()
}
