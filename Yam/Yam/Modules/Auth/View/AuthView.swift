import SwiftUI
import MapKit

struct AuthView: View {

    @StateObject private var viewModel = AuthViewModel()
    @FocusState private var focusedField: AuthField?
    
    var body: some View {
        NavBar(viewModel: viewModel) {
            Rectangle()
                .fill(Gradient.blackPurple)
                .opacity(0.5)
                .ignoresSafeArea()

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
        .onTapGesture {
            viewModel.hideKeyboard()
        }
        .ignoresSafeArea(.keyboard)
        .fullScreenCover(isPresented: $viewModel.isActiveEntry) {
            EntryView()
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

#Preview {
    AuthView()
}
