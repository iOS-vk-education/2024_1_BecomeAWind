import SwiftUI
import Combine

struct CreateEventViewSizesPack {
    static let newEventLabelFontSize: CGFloat = 30
    static let dateAndTimeLeadingPadding: CGFloat = 9

    static let imageSize: CGFloat = 20

    static let titleMaxLength = 70
    static let descriptionMaxLength = 350
    static let seatsMaxLength = 4
    static let contactMaxLength = 50

    static let lineLimit = 30
}

struct CreateEventView: View {
    @ObservedObject var viewModel: CreateEventViewModel
    @ObservedObject private var keyboardObserver = KeyboardObserver()

    @State private var title = ""
    @State private var description = ""
    @State private var date = Date() // todo date bounds
    @State private var seats = ""
    @State private var contact = ""

    @Binding var createEventViewIsActive: Bool
    @State var isActiveChooseEventPlaceView = false

    var body: some View {
        ZStack {
            List {
                Section {
                    HStack {
                        Spacer()
                        CreateEventText(text: "Новое мероприятие",
                                        fontSize: CreateEventViewSizesPack.newEventLabelFontSize)
                        Spacer()
                    }
                }
                .listRowBackground(ColorsPack.black)

                Group {
                    // Title, description, seats
                    Section {
                        CreateEventTextField(text: $title,
                                             title: "Название",
                                             lineLimit: CreateEventViewSizesPack.lineLimit)
                        .onReceive(Just(title)) { _ in
                            limitTextField(CreateEventViewSizesPack.titleMaxLength, text: $title)
                        }

                        CreateEventTextField(text: $description,
                                             title: "Описание",
                                             lineLimit: CreateEventViewSizesPack.lineLimit)
                        .onReceive(Just(description)) { _ in
                            limitTextField(CreateEventViewSizesPack.descriptionMaxLength, text: $description)
                        }

                        CreateEventTextField(text: $seats,
                                             title: "Количество мест",
                                             prompt: "Введите число",
                                             lineLimit: CreateEventViewSizesPack.lineLimit)
                        .keyboardType(.decimalPad)
                        .onChange(of: seats) { _, newValue in
                            seats = newValue.filter { seats.first != "0" && $0.isNumber }
                        }
                        .onReceive(Just(seats)) { _ in
                            limitTextField(CreateEventViewSizesPack.seatsMaxLength, text: $seats)
                        }
                    }

                    // Date and time
                    Section {
                        CreateEventText(text: "Дата и время")
                            .padding(.leading, CreateEventViewSizesPack.dateAndTimeLeadingPadding)

                        CreateEventDatePicker(date: $date)
                            .padding([.bottom, .top])
                    }

                    // Place
                    Section {
                        CreateEventText(text: "Место")
                            .padding(.leading, CreateEventViewSizesPack.dateAndTimeLeadingPadding)

                        CreateEventText(
                            text: viewModel.placeDescription,
                            fontWeight: .regular
                        )
                        .padding(.leading, CreateEventViewSizesPack.dateAndTimeLeadingPadding)


                        HStack {
                            Spacer()
                            Button {
                                isActiveChooseEventPlaceView.toggle()
                            } label: {
                                GradientImage(imageName: "mappin.circle",
                                              imageSize: CreateEventViewSizesPack.imageSize,
                                              background: GradientsPack.indigoPurple)
                            }
                            Spacer()
                        }


                    }

                    // Contact
                    Section {
                        CreateEventTextField(text: $contact,
                                             title: "Контакты создателя мероприятия",
                                             lineLimit: CreateEventViewSizesPack.lineLimit)
                        .onReceive(Just(title)) { _ in
                            limitTextField(CreateEventViewSizesPack.contactMaxLength, text: $contact)
                        }
                    }

                }
                .listRowBackground(ColorsPack.gray)
                .listRowSeparatorTint(ColorsPack.purple)
            }
            .background(ColorsPack.black)
            .scrollContentBackground(.hidden)
            .fullScreenCover(isPresented: $isActiveChooseEventPlaceView) {
                ChooseEventPlaceView(
                    viewModel: viewModel,
                    isActiveChooseEventPlaceView: $isActiveChooseEventPlaceView)
            }


            VStack {
                Spacer()
                HStack {
                    Spacer()
                    if keyboardObserver.isKeyboardVisible {
                        Button {
                            UIApplication.shared.endEditing()
                        } label: {
                            GradientImage(imageName: "arrowtriangle.down.circle",
                                          imageSize: CreateEventViewSizesPack.imageSize,
                                          background: GradientsPack.indigoPurple)
                        }
                        .padding([.bottom, .trailing], 10)
                    }
                }
            }

        }

        if !keyboardObserver.isKeyboardVisible {
            Button {
                if viewModel.createEvent(Event(title: title,
                                            description: description,
                                            place: viewModel.placeDescription,
                                            seats: Int(seats) ?? 0,
                                               contact: contact)) {
                    createEventViewIsActive.toggle()
                }
            } label: {
                HStack {
                    Spacer()
                    GradientLabel(title: "Создать")
                    Spacer()
                }
                .background(GradientsPack.indigoPurple)
            }
            .alert("Заполните все поля.", isPresented: $viewModel.emptyEventAlertIsActive) {
                Button("OK", role: .cancel) {}
            }

        }

    }

}

extension CreateEventView {
    private func limitTextField(_ upper: Int, text: Binding<String>) {
        if text.wrappedValue.count > upper {
            text.wrappedValue = String(text.wrappedValue.prefix(upper))
        }
    }
}

//#Preview {
//    @Previewable @State var bool = true
//    CreateEventView(viewModel: CreateEventViewModel(model: CreateEventModel()), createEventViewIsActive: $bool)
//}
