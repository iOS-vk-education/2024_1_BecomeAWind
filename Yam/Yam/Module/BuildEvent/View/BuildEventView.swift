import SwiftUI
import Combine

struct BuildEventView: View {

    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var viewModel: BuildEventViewModel
    @FocusState private var focusField: Field?

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
                    .focused($focusField, equals: .title)
                    .submitLabel(.next)

                BuildEventLink(viewModel: viewModel)
                    .focused($focusField, equals: .link)
                    .submitLabel(.next)

                BuildEventSeats(viewModel: viewModel)
                    .focused($focusField, equals: .seats)

                BuildEventDatePicker(viewModel: viewModel)

                BuildEventPlacePicker(viewModel: viewModel)

                FooterButtonsPack(viewModel: viewModel) {
                    dismiss()
                }

            }
            .onSubmit {
                switch focusField {
                case .title:
                    focusField = .link
                case .link:
                    focusField = .seats
                default:
                    break
                }
            }
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
        .alert("удалить ивент?", isPresented: $viewModel.savingAlert) {
            Button("отмена", role: .cancel) {}
            Button("удалить", role: .destructive) {
                Task {
                    await viewModel.deleteEvent() ? dismiss() : viewModel.toggleEventDeletionFailed()
                }
            }
        }
        .alert(
            "ошибка. не удалось удалить ивент. попробуй еще раз.",
            isPresented: $viewModel.eventDeletionFailed
        ) {
            Button("ок", role: .cancel) {}
        }
        .onTapGesture {
            viewModel.hideKeyboard()
        }
    }

}

#Preview {
    BuildEventView()
}

