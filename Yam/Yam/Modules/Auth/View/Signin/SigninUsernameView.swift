import SwiftUI

struct SigninUsernameView: View {

    @ObservedObject var viewModel: AuthViewModel

    var body: some View {
        YTextField(text: $viewModel.username, title: "имя пользователя", lineLimit: 1)
    }

}

#Preview {
    SigninUsernameView(viewModel: AuthViewModel())
}
