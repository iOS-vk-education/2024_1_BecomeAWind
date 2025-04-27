import SwiftUI
import Combine

struct MakeEventSeats: View {

    @ObservedObject var viewModel: MakeEventViewModel

    var body: some View {
        MakeEventTextField(
            text: $viewModel.allSeats,
            title: "Количество мест",
            prompt: "1",
            lineLimit: MakeEventConst.lineLimit
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
