import SwiftUI

struct EmailView: View {

    @ObservedObject var viewModel: AuthViewModel

    var body: some View {
        TextFieldView(
            text: $viewModel.email,
            title: "почта",
            lineLimit: 1,
            axis: .horizontal
        )
    }

}
