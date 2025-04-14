import SwiftUI

struct PasswordView: View {

    @ObservedObject var viewModel: AuthViewModel

    var body: some View {
        YTextField(text: $viewModel.password, title: "пароль", lineLimit: 1)
    }

}

#Preview {
    EmailView(viewModel: AuthViewModel())
}
