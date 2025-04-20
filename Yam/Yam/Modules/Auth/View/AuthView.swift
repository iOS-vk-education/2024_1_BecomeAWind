import SwiftUI
import MapKit

struct AuthView: View {

    @ObservedObject var viewModel: AuthViewModel
    @FocusState private var focusedField: AuthField?

    var body: some View {
        NavBar(viewModel: viewModel) {
            Map(interactionModes: [])

            ThinMaterialVStack {
                EmailView(viewModel: viewModel)
                    .focused($focusedField, equals: .email)
                    .submitLabel(.next)
                PasswordView(viewModel: viewModel)
                    .focused($focusedField, equals: .password)
                    .submitLabel(.done)
                AuthButton(viewModel: viewModel)
            }
            .onSubmit {
                focusedField = viewModel.getNextFocusedField(from: focusedField)
            }
        }
        .ignoresSafeArea(.keyboard)
        .onTapGesture {
            viewModel.hideKeyboard()
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
    }
}
