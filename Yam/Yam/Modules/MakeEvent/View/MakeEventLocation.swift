import SwiftUI
import Combine

struct MakeEventLocation: View {

    @ObservedObject var viewModel: MakeEventViewModel

    var body: some View {
        YTextField(
            text: $viewModel.link,
            title: "контакты создателя",
            prompt: "https://event.creator.link/",
            lineLimit: MakeEventConst.lineLimit,
            axis: .vertical
        )
        .onReceive(Just(link)) { _ in
            viewModel.limitTextField(
                MakeEventConst.contactMaxLength,
                text: $viewModel.link
            )
        }
    }

}

#Preview {
    MakeEventLocation(viewModel: MakeEventViewModel())
}
