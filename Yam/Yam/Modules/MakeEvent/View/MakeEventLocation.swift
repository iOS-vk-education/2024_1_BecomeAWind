import SwiftUI
import Combine

struct MakeEventLocation: View {

    @ObservedObject var viewModel: MakeEventViewModel

    var body: some View {
        MakeEventTextField(
            text: $viewModel.link,
            title: "Контакты создателя",
            prompt: "https://event.creator.link/",
            lineLimit: MakeEventConst.lineLimit
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
