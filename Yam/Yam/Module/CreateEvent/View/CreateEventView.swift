import SwiftUI
import Combine

enum CreateEventSizePack {
    static let titleMaxLength = 30
    static let descriptionMaxLength = 500
    static let seatsMaxLength = 4
    static let contactMaxLength = 200
    static let timeZoneFontSize: CGFloat = 15

    static let lineLimit = 30
}

struct CreateEventView: View {
    @StateObject private var viewModel = CreateEventViewModel(model: CreateEventModel())
    @ObservedObject private var keyboardObserver = KeyboardObserver()

    @State private var image: UIImage = UIImage(named: "default_event_image") ?? UIImage(systemName: "photo.artframe")!
    @State private var title = ""
    @State private var description = ""
    @State private var seats = "1"
    @State private var link = ""

    @State private var date = Date()
    @State private var timeZone = TimeZone.current

    @Binding var isActiveCreateEventView: Bool
    @State var isActiveChooseEventPlaceView = false

    var body: some View {
        ScrollView {
            CreateEventHeader()
            CreateEventImage(image: $image)

            // title
            CreateEventTextField(text: $title,
                                 title: "название \(Emoji.purpleCircle)",
                                 lineLimit: CreateEventSizePack.lineLimit)
            .onReceive(Just(title)) { _ in
                limitTextField(CreateEventSizePack.titleMaxLength, text: $title)
            }

            // description
            CreateEventTextField(text: $description,
                                 title: "описание",
                                 lineLimit: CreateEventSizePack.lineLimit)
            .onReceive(Just(description)) { _ in
                limitTextField(CreateEventSizePack.descriptionMaxLength, text: $description)
            }

            // seats
            CreateEventTextField(text: $seats,
                                 title: "количество мест \(Emoji.purpleCircle)",
                                 prompt: "1",
                                 lineLimit: CreateEventSizePack.lineLimit)
            .keyboardType(.decimalPad)
            .onChange(of: seats) { _, newValue in
                seats = newValue.filter { seats.first != "0" && $0.isNumber }
            }
            .onReceive(Just(seats)) { _ in
                limitTextField(CreateEventSizePack.seatsMaxLength, text: $seats)
            }

            // link
            CreateEventTextField(text: $link,
                                 title: "контакты создателя \(Emoji.purpleCircle)",
                                 lineLimit: CreateEventSizePack.lineLimit)
            .onReceive(Just(link)) { _ in
                limitTextField(CreateEventSizePack.contactMaxLength, text: $link)
            }

            // date time timezone
            CreateEventDatePicker(date: $date,
                                  timeZone: $timeZone)

            // place



//            List {
//                Group {
//
//
//                    // Place
//                    Section {
//                        YamWhiteText(text: "место \(Emoji.purpleCircle)")
//                            .padding(.leading, CreateEventSizePack.dateAndTimeLeadingPadding)
//
//                        YamWhiteText(
//                            text: viewModel.placeDescription,
//                            fontWeight: .regular
//                        )
//                        .padding(.leading, CreateEventSizePack.dateAndTimeLeadingPadding)
//
//                        HStack {
//                            Spacer()
//                            Button {
//                                isActiveChooseEventPlaceView.toggle()
//                            } label: {
//                                YamMappin()
//                            }
//                            Spacer()
//                        }
//
//                    }
//                }
//                .listRowBackground(ColorPack.gray)
//                .listRowSeparatorTint(ColorPack.purple)
//            }
            //                .background(ColorPack.black)
            //                .scrollContentBackground(.hidden)
            //                .fullScreenCover(isPresented: $isActiveChooseEventPlaceView) {
            //                    ChooseEventPlaceView(
            //                        viewModel: viewModel,
            //                        isActiveChooseEventPlaceView: $isActiveChooseEventPlaceView)
            //                }
            //        }


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
                                          imageSize: SizePack.smallImageSize,
                                          background: GradientPack.purpleIndigo)
                        }
                        .padding([.bottom, .trailing], 10)
                    }
                }
            }

            //        }

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
                        YamCapsuleLabel(title: "создать")
                        Spacer()
                    }
                    .background(GradientPack.purpleIndigo)
                }
                .alert("Заполните все обязательные поля \(Emoji.purpleCircle)", isPresented: $viewModel.emptyEventAlertIsActive) {
                    Button("OK", role: .cancel) {}
                }

            }

        }
        .background(ColorPack.black)

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
