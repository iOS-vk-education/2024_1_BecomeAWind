import SwiftUI
import Combine

enum CreateEventSizePack {
    static let titleMaxLength = 30
    static let descriptionMaxLength = 500
    static let seatsMaxLength = 4
    static let contactMaxLength = 200

    static let lineLimit = 30

    static let placeDescriptionFontSize: CGFloat = 15
}

enum CreateEventCommonItem {
    static let emptyPlaceText = "выбери место проведения мероприятия"
}

struct CreateEventView: View {
    @Environment(\.dismiss) var dismiss

    @StateObject private var viewModel = CreateEventViewModel(model: CreateEventModel())


    
    @ObservedObject private var keyboardObserver = KeyboardObserver.shared

    @State private var image: UIImage = UIImage(named: "default_event_image") ?? UIImage(systemName: "photo.artframe")!
    @State private var title = ""
    @State private var description = ""
    @State private var seats = "1"
    @State private var link = ""
    @State private var date = Date()
    @State private var timeZone = TimeZone.current

//    @Binding var isActiveCreateEventView: Bool

//    @FocusState private var activeTextField: String?

    var body: some View {
//        ScrollViewReader { proxy in
            ScrollView(showsIndicators: false) {
                /// dismiss
                CreateEventDismissButton {
                    dismiss()
                }

                /// title
                YamText(
                    "новый ивент",
                    font: CreateEventFont.headerTextFont
                )

                /// image picker
                CreateEventImagePicker(image: $image)

                // title
                CreateEventTextField(text: $title,
                                     title: "название \(Emoji.purpleCircle)",
                                     lineLimit: CreateEventSizePack.lineLimit)
                .onReceive(Just(title)) { _ in
                    limitTextField(CreateEventSizePack.titleMaxLength, text: $title)
                }
//                .id("title")
//                .focused($activeTextField, equals: "title")

                // description
                CreateEventTextField(text: $description,
                                     title: "описание",
                                     lineLimit: CreateEventSizePack.lineLimit)
                .onReceive(Just(description)) { _ in
                    limitTextField(CreateEventSizePack.descriptionMaxLength, text: $description)
                }
//                .id("description")
//                .focused($activeTextField, equals: "description")

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
//                .id("seats")
//                .focused($activeTextField, equals: "seats")

                // date time timezone
                CreateEventDatePicker(date: $date,
                                      timeZone: $timeZone) // need optimize

                // place picker
                CreateEventPlacePicker(viewModel: viewModel)

                // link
                CreateEventTextField(text: $link,
                                     title: "контакты создателя \(Emoji.purpleCircle)",
                                     lineLimit: CreateEventSizePack.lineLimit)
                .onReceive(Just(link)) { _ in
                    limitTextField(CreateEventSizePack.contactMaxLength, text: $link)
                }
//                .id("link")
//                .focused($activeTextField, equals: "link")




                // hide keyboard button
                //            if keyboardObserver.isKeyboardVisible {
                //                VStack {
                //                    Spacer()
                //                    HStack {
                //                        Spacer()
                //                        Button {
                //                            UIApplication.shared.endEditing()
                //                        } label: {
                //                            GradientImage(imageName: "arrowtriangle.down.circle",
                //                                          imageSize: SizePack.smallImageSize,
                //                                          background: GradientPack.purpleIndigo)
                //                        }
                //                        .padding([.bottom, .trailing], 10)
                //                    }
                //                }
                //            }

                //        }

                // create event button
                //            if !keyboardObserver.isKeyboardVisible {
                //                Button {
                //                    if viewModel.createEvent(
                //                        Event(description: EventDescription(title: title,
                //                                                            description: description,
                //                                                            image: image),
                //                              organization: EventOrganizationInformation(date:
                //                                                                            DateModel(date: date,
                //                                                                                      timeZone: timeZone),
                //                                                                         place: viewModel.place,
                //                                                                         seats: Int(seats) ?? 1,
                //                                                                         link: link))) {
                //                        isActiveCreateEventView.toggle()
                //                    }
                //                } label: {
                //                    HStack {
                //                        Spacer()
                //                        YamCapsuleLabel(title: "создать")
                //                        Spacer()
                //                    }
                //                    .background(GradientPack.purpleIndigo)
                //                }
                //                .alert("заполни все обязательные поля \(Emoji.purpleCircle)", isPresented: $viewModel.emptyEventAlertIsActive) {
                //                    Button("ок", role: .cancel) {}
                //                }
                //
                //            }

            }
            .background(Colors.black)
//            .onChange(of: activeTextField) { field in
//                if let field = field {
//                    withAnimation {
//                        proxy.scrollTo(field, anchor: .top)
//                    }
//                }
//            }
//            .onAppear {
//                keyboardObserver.addKeyboardObservers()
//            }
//            .onDisappear {
//                keyboardObserver.removeKeyboardObservers()
//            }
//        }
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
    CreateEventView()
}

