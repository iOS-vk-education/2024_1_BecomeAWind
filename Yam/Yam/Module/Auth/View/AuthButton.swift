import SwiftUI

struct AuthButton: View {

    @ObservedObject var viewModel: AuthViewModel

    var body: some View {
        CapsuleButton(title: viewModel.activeTab == .signIn ? "войти" : "создать аккаунт") {
            viewModel.auth()
        }
    }

}

