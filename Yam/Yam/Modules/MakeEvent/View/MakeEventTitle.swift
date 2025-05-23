import SwiftUI
import Combine

struct MakeEventTitle: View {

    @ObservedObject var viewModel: MakeEventViewModel

    var body: some View {
        MakeEventTextField(
            text: $viewModel.eventTitle,
            title: "название",
            prompt: "расскажи об ивенте",
            lineLimit: MakeEventConst.lineLimit
        )
        .onReceive(Just(viewModel.eventTitle)) { _ in
            viewModel.limitTextField(
                MakeEventConst.titleMaxLength,
                text: $viewModel.eventTitle
            )
        }
    }

}

#Preview {
    MakeEventTitle(viewModel: MakeEventViewModel())
}
