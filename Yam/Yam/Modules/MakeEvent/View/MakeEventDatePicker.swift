import SwiftUI

struct MakeEventDatePicker: View {

    @ObservedObject var viewModel: MakeEventViewModel

    var body: some View {
        HStack {
            YText(
                "дата и время",
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
            .environment(\.locale, Locales.ru)
            .tint(Colors.purple)
            .colorScheme(.dark)
            .padding()
        }
    }

}

#Preview {
    MakeEventDatePicker(viewModel: MakeEventViewModel())
}
