import SwiftUI
import Combine

struct MakeEventSeats: View {

    @ObservedObject var viewModel: MakeEventViewModel

    var body: some View {
        YTextField(
            text: $viewModel.allSeats,
            title: "количество мест",
            prompt: "1",
            lineLimit: MakeEventConst.lineLimit,
            axis: .vertical
        )
        .keyboardType(.decimalPad)
        .onChange(of: viewModel.allSeats) { _, newValue in
            viewModel.filterSeats(newValue)
        }
        .onReceive(Just($viewModel.allSeats)) { _ in
            viewModel.limitTextField(
                MakeEventConst.seatsMaxLength,
                text: $viewModel.allSeats
            )
        }
    }

}

#Preview {
    MakeEventSeats(viewModel: MakeEventViewModel())
}
