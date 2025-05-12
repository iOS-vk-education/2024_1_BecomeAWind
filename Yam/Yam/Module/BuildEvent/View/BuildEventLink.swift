import SwiftUI
import Combine

struct BuildEventLink: View {

    @ObservedObject var viewModel: BuildEventViewModel

    var body: some View {
        TextFieldView(
            text: $viewModel.link,
            title: "контакты создателя",
            prompt: "https://event.creator.link/",
            lineLimit: BuildEventConst.lineLimit,
            axis: .horizontal
        )
        .onReceive(Just(link)) { _ in
            viewModel.limitTextField(
                BuildEventConst.contactMaxLength,
                text: $viewModel.link
            )
        }
    }

}

#Preview {
    BuildEventLink(viewModel: BuildEventViewModel())
}
