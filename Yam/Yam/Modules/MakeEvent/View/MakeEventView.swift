import SwiftUI
import Combine
import UIKit

struct MakeEventView: View {

    enum Field {
        case title, seats, link, description
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

                MakeEventDescription(viewModel: viewModel)
                    .focused($focus, equals: .description)

                MakeEventSeats(viewModel: viewModel)
                    .focused($focus, equals: .seats)

                MakeEventLocation(viewModel: viewModel)
                    .focused($focus, equals: .link)

                MakeEventDatePicker(viewModel: viewModel)

                MakeEventPlacePicker(viewModel: viewModel)

                MakeEventFooterButton(viewModel: viewModel) { dismiss() }
            }
            .scrollDismissesKeyboard(.interactively)
            .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
            

//            MakeEventHideKeyboardButton {
//                focus = nil
//            }
//            .opacity(focus == nil ? 0 : 1)
        }
        .alert(
            "Заполни все поля",
            isPresented: $viewModel.eventCreationFailed
        ) {
            Button("ОК", role: .cancel) {}
        }
        .alert(
            "Заполни все поля и введи количество мест не меньше предыдущего",
            isPresented: $viewModel.eventEditionFailed
        ) {
            Button("ОК", role: .cancel) {}
        }
    }

}

extension UIApplication: @retroactive UIGestureRecognizerDelegate {
    func addTapGestureRecognizer() {
        guard let window = windows.first else { return }
        let tapGesture = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        tapGesture.name = "MyTapGesture"
        window.addGestureRecognizer(tapGesture)
    }
}

#Preview {
    MakeEventView(viewModel: MakeEventViewModel())
}

