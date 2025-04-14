import SwiftUI

struct PasswordView: View {

    @ObservedObject var viewModel: AuthViewModel

    var body: some View {
        YSecureField(text: $viewModel.password, title: "пароль", lineLimit: 1)
    }

}

#Preview {
    EmailView(viewModel: AuthViewModel())
}
