import SwiftUI
import Combine

struct MakeEventView: View {

    enum Field {
        case title, seats, link
    }

    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: MakeEventViewModel
    @FocusState private var focus: Field?

    init(viewModel: MakeEventViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                DismissButton { dismiss() }

                MakeEventHeader(text: viewModel.headerText)

                MakeEventImagePicker(viewModel: viewModel)

                MakeEventTitle(viewModel: viewModel)
                    .focused($focus, equals: .title)

                MakeEventSeats(viewModel: viewModel)
                    .focused($focus, equals: .seats)

                MakeEventLocation(viewModel: viewModel)
                    .focused($focus, equals: .link)

                MakeEventDatePicker(viewModel: viewModel)

                MakeEventPlacePicker(viewModel: viewModel)

                MakeEventFooterButton(viewModel: viewModel) { dismiss() }
            }

            MakeEventHideKeyboardButton {
                focus = nil
            }
            .opacity(focus == nil ? 0 : 1)
        }
        .alert(
            "заполни все поля",
            isPresented: $viewModel.eventCreationFailed
        ) {
            Button("ок", role: .cancel) {}
        }
        .alert(
            "заполни все поля и введи количество мест не меньше предыдущего",
            isPresented: $viewModel.eventEditionFailed
        ) {
            Button("ок", role: .cancel) {}
        }
    }

}

#Preview {
    MakeEventView(viewModel: MakeEventViewModel())
}

