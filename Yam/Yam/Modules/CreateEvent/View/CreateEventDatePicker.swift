import SwiftUI

struct CreateEventDatePicker: View {

    @ObservedObject var viewModel: CreateEventViewModel

    var body: some View {
        HStack {
            YText(
                "дата и время",
                font: CreateEventFont.sectionTitleFont
            )
            Spacer()
        }
        .padding(.leading, Const.sideSpace)

        CreateEventVStack {
            DatePicker(
                "выбери дату и время",
                selection: $viewModel.date
            )
            .labelsHidden()
            .environment(\.locale, Locales.ru)
            .font(CreateEventFont.sectionContentFont)
            .tint(Colors.purple)
            .colorScheme(.dark)
            .padding()
        }
    }

}

#Preview {
    @Previewable @StateObject var vm = CreateEventViewModel(model: CreateEventModel())
    CreateEventDatePicker(viewModel: vm)
}
