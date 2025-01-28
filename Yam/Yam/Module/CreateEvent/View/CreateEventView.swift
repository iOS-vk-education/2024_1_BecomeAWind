import SwiftUI
import Combine
import PhotosUI

enum CreateEventViewSizesPack {
    static let newEventLabelFontSize: CGFloat = 30
    static let dateAndTimeLeadingPadding: CGFloat = 9

    static let imageSize: CGFloat = 20

    static let titleMaxLength = 30
    static let descriptionMaxLength = 500
    static let seatsMaxLength = 4
    static let contactMaxLength = 50

    static let lineLimit = 30
}

struct CreateEventView: View {
    @StateObject private var viewModel = CreateEventViewModel(model: CreateEventModel())
    @ObservedObject private var keyboardObserver = KeyboardObserver()

    @State private var photosPickerItem: PhotosPickerItem?
    @State private var image: UIImage = (UIImage(named: "defaulteventimage") ?? UIImage(systemName: "photo.artframe"))! // todo remove spacers clickability
    @State private var title = ""
    @State private var description = ""
    @State private var seats = "1"
    @State private var link = ""

    @State private var date = Date() // todo date bounds
    @State private var timeZone = TimeZone.current

    @Binding var isActiveCreateEventView: Bool
    @State var isActiveChooseEventPlaceView = false

    var body: some View {
        ZStack {
            List {
                Section {
                    HStack {
                        Spacer()
                        YamText(text: "Новое мероприятие",
                                fontSize: CreateEventViewSizesPack.newEventLabelFontSize)
                        Spacer()
                    }
                }
                .listRowBackground(ColorPack.black)

                // Image
                Section {
                    HStack {
                        Spacer()
                        PhotosPicker(selection: $photosPickerItem, matching: .images) {
                            YamImage(image: image)
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
                .listRowBackground(ColorPack.black)

                Group {
                    // Title, description, seats, contact
                    Section {
                        CreateEventTextField(text: $title,
                                             title: "Название \(Emoji.purpleCircle)",
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
                                             title: "Количество мест \(Emoji.purpleCircle)",
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
                                             title: "Контакты создателя мероприятия \(Emoji.purpleCircle)",
                                             lineLimit: CreateEventViewSizesPack.lineLimit)
                        .onReceive(Just(title)) { _ in
                            limitTextField(CreateEventViewSizesPack.contactMaxLength, text: $link)
                        }
                    }

                    // Date, time, timezone
                    Section {
                        YamText(text: "Дата, время, часовой пояс")
                            .padding(.leading, CreateEventViewSizesPack.dateAndTimeLeadingPadding)

                        CreateEventDatePicker(date: $date, timeZone: $timeZone)
                            .padding([.bottom, .top])
                    }

                    // Place
                    Section {
                        YamText(text: "Место \(Emoji.purpleCircle)")
                            .padding(.leading, CreateEventViewSizesPack.dateAndTimeLeadingPadding)

                        YamText(
                            text: viewModel.placeDescription,
                            fontWeight: .regular
                        )
                        .padding(.leading, CreateEventViewSizesPack.dateAndTimeLeadingPadding)

                        HStack {
                            Spacer()
                            Button {
                                isActiveChooseEventPlaceView.toggle()
                            } label: {
                                YamMappin()
                            }
                            Spacer()
                        }

                    }
                }
                .listRowBackground(ColorPack.gray)
                .listRowSeparatorTint(ColorPack.purple)
            }
            .background(ColorPack.black)
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
                                          background: GradientPack.purpleIndigo)
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
                                                                                  timeZone: timeZone),
                                                                     place: viewModel.place,
                                                                     seats: Int(seats) ?? 1,
                                                                     link: link))) {
                    isActiveCreateEventView.toggle()
                }
            } label: {
                HStack {
                    Spacer()
                    YamCapsuleLabel(title: "Создать")
                    Spacer()
                }
                .background(GradientPack.purpleIndigo)
            }
            .alert("Заполните все обязательные поля \(Emoji.purpleCircle)", isPresented: $viewModel.emptyEventAlertIsActive) {
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
    CreateEventView(isActiveCreateEventView: $bool)
}
