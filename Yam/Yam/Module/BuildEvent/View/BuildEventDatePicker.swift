import SwiftUI

struct BuildEventDatePicker: View {

    @ObservedObject var viewModel: BuildEventViewModel

    var body: some View {
        HStack {
            YText(
                "дата и время",
                font: Const.sectionTitleFont
            )
            Spacer()
        }
        .padding(.leading)

        BuildEventVStack {
            DatePicker(
                "",
                selection: $viewModel.date
            )
            .labelsHidden()
            .environment(\.locale, Locale(identifier: "ru_RU"))
            .background(.thinMaterial)
            .tint(.purple)
            .colorScheme(.dark)
            .padding()
        }
    }

}

#Preview {
    BuildEventDatePicker(viewModel: BuildEventViewModel())
}
