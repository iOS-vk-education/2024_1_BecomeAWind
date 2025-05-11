import SwiftUI

struct AuthButton: View {

    @ObservedObject var viewModel: AuthViewModel

    var body: some View {
        Button {
            viewModel.auth()
        } label: {
            if !viewModel.authInProgress {
                Text(viewModel.activeTab == .signIn ? "войти" : "создать аккаунт")
                    .fixedSizeText()
            } else {
                ProgressView()
                    .fixedSizeView()
            }
        }
        .disabled(viewModel.authInProgress)
    }

}

