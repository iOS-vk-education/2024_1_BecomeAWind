import SwiftUI

struct MakeEventDatePicker: View {

    @ObservedObject var viewModel: MakeEventViewModel

    var body: some View {
        HStack {
            YText(
                "Дата и время",
                font: MakeEventConst.sectionTitleFont
            )
            Spacer()
        }
        .padding(.leading, Const.sideSpace)

        MakeEventVStack {
            DatePicker(
                "",
                selection: $viewModel.date
            )
            .labelsHidden()
            .environment(\.locale, Locale(identifier: "ru_RU"))
            .tint(.purple)
            .colorScheme(.dark)
            .padding()
        }
    }

}

#Preview {
    MakeEventDatePicker(viewModel: MakeEventViewModel())
}
