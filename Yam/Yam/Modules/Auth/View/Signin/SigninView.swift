import SwiftUI

struct AuthSigninView: View {

    @ObservedObject var viewModel: AuthViewModel

    var body: some View {
        SigninUsernameView(viewModel: viewModel)
    }

}

//#Preview {
////    AuthSigninView(viewModel: viewModel)
//}
