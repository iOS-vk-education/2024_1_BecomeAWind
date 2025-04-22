import SwiftUI
import Combine

struct BuildEventView: View {

    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var viewModel: BuildEventViewModel
    @FocusState private var focus: Field?

    init(viewModel: BuildEventViewModel = BuildEventViewModel()) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                DismissButton { dismiss() }

                BuildEventHeader(text: viewModel.headerText)

                BuildEventImagePicker(viewModel: viewModel)

                BuildEventTitle(viewModel: viewModel)
                    .focused($focus, equals: .title)

                BuildEventSeats(viewModel: viewModel)
                    .focused($focus, equals: .seats)

                BuildEventLocation(viewModel: viewModel)
                    .focused($focus, equals: .link)

                BuildEventDatePicker(viewModel: viewModel)

                BuildEventPlacePicker(viewModel: viewModel)

                BuildEventFooterButton(viewModel: viewModel) { dismiss() }
            }

            BuildEventHideKeyboardButton {
                focus = nil
            }
            .opacity(focus == nil ? 0 : 1)
        }
        .alert(
            "ошибка. проверь, все ли поля заполнены и попробуй еще раз",
            isPresented: $viewModel.eventCreationFailed
        ) {
            Button("ок", role: .cancel) {}
        }
        .alert(
            "ошибка. проверь, все ли поля заполнены, убедись, что введенное количество мест не меньше предыдущего, попробуй еще раз",
            isPresented: $viewModel.eventEditionFailed
        ) {
            Button("ок", role: .cancel) {}
        }
    }

}

#Preview {
    BuildEventView()
}

