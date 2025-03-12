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
                /// dismiss
                YCircleButton(
                    imageName: "xmark",
                    background: Gradients.pinkIndigo
                ) {
                    dismiss()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding([.trailing, .top], Const.sideSpace)

                /// header
                YText(
                    "новый ивент",
                    font: Const.headerTextFont
                )

                /// image picker
                MakeEventImagePicker(viewModel: viewModel)

                /// title
                MakeEventTextField(
                    text: $viewModel.eventTitle,
                    title: "название",
                    prompt: "расскажи об ивенте",
                    lineLimit: MakeEventConst.lineLimit
                )
                .onReceive(Just(viewModel.eventTitle)) { _ in
                    viewModel.limitTextField(
                        MakeEventConst.titleMaxLength,
                        text: $viewModel.eventTitle
                    )
                }
                .focused($focus, equals: .title)

                /// seats
                MakeEventTextField(
                    text: $viewModel.allSeats,
                    title: "количество свободных мест",
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
                .focused($focus, equals: .seats)

                /// link
                MakeEventTextField(
                    text: $viewModel.link,
                    title: "контакты создателя",
                    prompt: "https://event.creator.link/",
                    lineLimit: MakeEventConst.lineLimit
                )
                .onReceive(Just(link)) { _ in
                    viewModel.limitTextField(
                        MakeEventConst.contactMaxLength,
                        text: $viewModel.link
                    )
                }
                .focused($focus, equals: .link)

                /// date time
                MakeEventDatePicker(viewModel: viewModel)

                /// place picker
                MakeEventPlacePicker(viewModel: viewModel)

                /// create event button
                Button {
                    if viewModel.createEvent() {
                        dismiss()
                    } else {
                        viewModel.toggleEventCreationFailed()
                    }
                } label: {
                    YCapsuleLabel(
                        title: "создать",
                        font: Const.buttonFont
                    )
                }

            }

            YCircleButton(imageName: "arrowtriangle.down") {
                focus = nil
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .bottomTrailing
            )
            .padding([.bottom, .trailing], Const.sideSpace)
            .opacity(focus == nil ? 0 : 1)
        }
        .alert(
            "заполни все поля",
            isPresented: $viewModel.eventCreationFailed
        ) {
            Button("ок", role: .cancel) {}
        }
    }

}

#Preview {
    MakeEventView(viewModel: MakeEventViewModel())
}

