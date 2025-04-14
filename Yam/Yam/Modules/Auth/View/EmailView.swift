import SwiftUI

struct EmailView: View {

    @ObservedObject var viewModel: AuthViewModel

    var body: some View {
        YTextField(text: $viewModel.email, title: "почта", lineLimit: 1)
    }

}

#Preview {
    EmailView(viewModel: AuthViewModel())
}
