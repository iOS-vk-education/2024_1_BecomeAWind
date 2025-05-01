import SwiftUI
import Combine

struct BuildEventTitle: View {

    @ObservedObject var viewModel: BuildEventViewModel

    var body: some View {
        YTextField(
            text: $viewModel.eventTitle,
            title: "название",
            prompt: "расскажи об ивенте",
            lineLimit: BuildEventConst.lineLimit,
            axis: .horizontal
        )
        .onReceive(Just(viewModel.eventTitle)) { _ in
            viewModel.limitTextField(
                BuildEventConst.titleMaxLength,
                text: $viewModel.eventTitle
            )
        }
    }

}

#Preview {
    BuildEventTitle(viewModel: BuildEventViewModel())
}
