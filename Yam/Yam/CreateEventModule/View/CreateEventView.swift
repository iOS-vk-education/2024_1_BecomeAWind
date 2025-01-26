import SwiftUI
import Combine
import PhotosUI

struct CreateEventViewSizesPack {
    static let newEventLabelFontSize: CGFloat = 25
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

    @State private var photosPickerItem: PhotosPickerItem?
    @State private var image: UIImage = (UIImage(named: "defaulteventimage") ?? UIImage(systemName: "photo.artframe"))!
    @State private var title = ""
    @State private var description = ""
    @State private var seats = "1"
    @State private var link = ""

    @State private var date = Date() // todo date bounds
    @State private var timeZone = TimeZone.current

    @Binding var createEventViewIsActive: Bool
    @State var isActiveChooseEventPlaceView = false

    var delme = EventsMock()

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
                    // Image
                    Section {
                        HStack {
                            Spacer()
                            VStack {
                                PhotosPicker(selection: $photosPickerItem, matching: .images) {
                                    Image(uiImage: image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 150, height: 150)
                                        .clipShape(.buttonBorder)
                                }
                            }
                            .onChange(of: photosPickerItem) {
                                Task {
                                    if let photosPickerItem,
                                       let data = try? await photosPickerItem.loadTransferable(type: Data.self) {
                                        if let img = UIImage(data: data) {
                                            image = img
                                        }
                                    }
                                    photosPickerItem = nil
                                }
                            }
                            Spacer()

                        }
                    }

                    // Title, description, seats, contact
                    Section {
                        CreateEventTextField(text: $title,
                                             title: "Название \(Emojis.purpleCircle)",
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
                                             title: "Количество мест \(Emojis.purpleCircle)",
                                             prompt: "1",
                                             lineLimit: CreateEventViewSizesPack.lineLimit)
                        .keyboardType(.decimalPad)
                        .onChange(of: seats) { _, newValue in
                            seats = newValue.filter { seats.first != "0" && $0.isNumber }
                        }
                        .onReceive(Just(seats)) { _ in
                            limitTextField(CreateEventViewSizesPack.seatsMaxLength, text: $seats)
                        }

                        CreateEventTextField(text: $link,
                                             title: "Контакты создателя мероприятия \(Emojis.purpleCircle)",
                                             lineLimit: CreateEventViewSizesPack.lineLimit)
                        .onReceive(Just(title)) { _ in
                            limitTextField(CreateEventViewSizesPack.contactMaxLength, text: $link)
                        }
                    }

                    // Date, time, timezone
                    Section {
                        CreateEventText(text: "Дата, время, часовой пояс")
                            .padding(.leading, CreateEventViewSizesPack.dateAndTimeLeadingPadding)

                        CreateEventDatePicker(date: $date, timeZone: $timeZone)
                            .padding([.bottom, .top])
                    }

                    // Place
                    Section {
                        CreateEventText(text: "Место \(Emojis.purpleCircle)")
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

            // hide keyboard button
            if keyboardObserver.isKeyboardVisible {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
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

        // create event button
        if !keyboardObserver.isKeyboardVisible {
            Button {
                if viewModel.createEvent(
                    Event(description: EventDescription(title: title,
                                                        description: description,
                                                        image: image),
                          organization: EventOrganizationInformation(date:
                                                                        DateModel(date: date,
                                                                                  timeZome: timeZone),
                                                                     place: viewModel.placeDescription,
                                                                     seats: Int(seats) ?? 1,
                                                                     link: link))) {
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
            .alert("Заполните все обязательные поля \(Emojis.purpleCircle)", isPresented: $viewModel.emptyEventAlertIsActive) {
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

#Preview {
    @Previewable @State var bool = true
    CreateEventView(viewModel: CreateEventViewModel(model: CreateEventModel()), createEventViewIsActive: $bool)
}
