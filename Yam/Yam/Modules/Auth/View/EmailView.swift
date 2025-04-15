import SwiftUI

struct EmailView: View {

    @ObservedObject var viewModel: AuthViewModel

    var body: some View {
        YTextField(
            text: $viewModel.email,
            title: "почта",
            lineLimit: 1,
            axis: .horizontal
        )
    }

}

#Preview {
    EmailView(viewModel: AuthViewModel())
}
