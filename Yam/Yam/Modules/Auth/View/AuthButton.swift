import SwiftUI

struct AuthButton: View {

    @ObservedObject var viewModel: AuthViewModel

    var body: some View {
        Button {
            viewModel.auth()
        } label: {
            YCapsuleLabel(
                title: viewModel.activeTab == .signIn ? "войти" : "создать аккаунт",
                font: Const.buttonFont
            )
        }
    }

}

#Preview {
    AuthButton(viewModel: AuthViewModel())
}
