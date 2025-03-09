import SwiftUI
import Combine

enum CreateEventCommonItem {
    static let emptyPlaceText = "выбери место проведения мероприятия"
}

struct CreateEventView: View {

    enum Field {
        case title, seats, link
    }

    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = CreateEventViewModel(model: CreateEventModel())

    @FocusState private var focus: Field?

    @State private var date = Date()

    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                /// dismiss
                YCircleButton(imageName: "xmark") {
                    dismiss()
                }

                /// header
                YText(
                    "новый ивент",
                    font: CreateEventFont.headerTextFont
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
                    text: $viewModel.seats,
                    title: "количество мест",
                    prompt: "1",
                    lineLimit: CreateEventConst.lineLimit
                )
                .keyboardType(.decimalPad)
                .onChange(of: viewModel.seats) { _, newValue in
                    viewModel.filterSeats(newValue)
                }
                .onReceive(Just($viewModel.seats)) { _ in
                    viewModel.limitTextField(
                        CreateEventConst.seatsMaxLength,
                        text: $viewModel.seats
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

                /// date time timezone
                CreateEventDatePicker(viewModel: viewModel)

                /// place picker
                CreateEventPlacePicker(viewModel: viewModel)
            }
            .background(Colors.black)

            VStack {
                Spacer()
                YCircleButton(imageName: "arrowtriangle.down") {
                    focus = nil
                }
            }
            .padding(.bottom, Const.sideSpace)
            .opacity(focus == nil ? 0 : 1)
        }
    }

}

#Preview {
    CreateEventView()
}

