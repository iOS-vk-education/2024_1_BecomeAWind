import SwiftUI
import Combine

struct CreateEventView: View {

    enum Field {
        case title, seats, link
    }

    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = CreateEventViewModel()
    @FocusState private var focus: Field?

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
                .padding(.trailing, Const.sideSpace)

                /// header
                YText(
                    "новый ивент",
                    font: Const.headerTextFont
                )

                /// image picker
                CreateEventImagePicker(viewModel: viewModel)

                /// title
                CreateEventTextField(
                    text: $viewModel.eventTitle,
                    title: "название",
                    prompt: "расскажи об ивенте",
                    lineLimit: CreateEventConst.lineLimit
                )
                .onReceive(Just(viewModel.eventTitle)) { _ in
                    viewModel.limitTextField(
                        CreateEventConst.titleMaxLength,
                        text: $viewModel.eventTitle
                    )
                }
                .focused($focus, equals: .title)

                /// seats
                CreateEventTextField(
                    text: $viewModel.allSeats,
                    title: "количество свободных мест",
                    prompt: "1",
                    lineLimit: CreateEventConst.lineLimit
                )
                .keyboardType(.decimalPad)
                .onChange(of: viewModel.allSeats) { _, newValue in
                    viewModel.filterSeats(newValue)
                }
                .onReceive(Just($viewModel.allSeats)) { _ in
                    viewModel.limitTextField(
                        CreateEventConst.seatsMaxLength,
                        text: $viewModel.allSeats
                    )
                }
                .focused($focus, equals: .seats)

                /// link
                CreateEventTextField(
                    text: $viewModel.link,
                    title: "контакты создателя",
                    prompt: "https://event.creator.link/",
                    lineLimit: CreateEventConst.lineLimit
                )
                .onReceive(Just(link)) { _ in
                    viewModel.limitTextField(
                        CreateEventConst.contactMaxLength,
                        text: $viewModel.link
                    )
                }
                .focused($focus, equals: .link)

                /// date time
                CreateEventDatePicker(viewModel: viewModel)

                /// place picker
                CreateEventPlacePicker(viewModel: viewModel)

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
    CreateEventView()
}

