import SwiftUI
import Combine

struct BuildEventLocation: View {

    @ObservedObject var viewModel: BuildEventViewModel

    var body: some View {
        YTextField(
            text: $viewModel.link,
            title: "контакты создателя",
            prompt: "https://event.creator.link/",
            lineLimit: BuildEventConst.lineLimit,
            axis: .vertical
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
    BuildEventLocation(viewModel: BuildEventViewModel())
}
