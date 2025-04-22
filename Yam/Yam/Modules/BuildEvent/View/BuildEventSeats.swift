import SwiftUI
import Combine

struct BuildEventSeats: View {

    @ObservedObject var viewModel: BuildEventViewModel

    var body: some View {
        YTextField(
            text: $viewModel.allSeats,
            title: "количество мест",
            prompt: "1",
            lineLimit: BuildEventConst.lineLimit,
            axis: .vertical
        )
        .keyboardType(.decimalPad)
        .onChange(of: viewModel.allSeats) { _, newValue in
            viewModel.filterSeats(newValue)
        }
        .onReceive(Just($viewModel.allSeats)) { _ in
            viewModel.limitTextField(
                BuildEventConst.seatsMaxLength,
                text: $viewModel.allSeats
            )
        }
    }

}

#Preview {
    BuildEventSeats(viewModel: BuildEventViewModel())
}
