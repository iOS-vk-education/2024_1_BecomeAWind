import SwiftUI

struct EventCard: View {
    var event: Event

    var body: some View {
        VStack(alignment: .leading) {
            HeaderEvent(info: event.description)
            EventDescriptionView(descriprion: event.description.description)
            Spacer()
            ContentEventView(event: event)
        }
        .background(Color("ViewDetalGray"))
        .cornerRadius(30)
        .shadow(radius: 5)
    }
}

struct HeaderEvent: View {
    @State var info: EventDescription

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            EventImage(image: info.image)
            EventTitle(title: info.title)
        }
    }
}

struct ContentEventView: View {
    @State var event: Event
    @State var isActiveEventLocationView = false

    var body: some View {
        VStack {
            HStack {
                Spacer()
//                YamCapsuleLabel(title: "свободные места: \(String(event.organization.seats))")
                Spacer()
            }
            .background(GradientPack.greenPurple)
            .cornerRadius(SizePack.coreCornerRadius)

            HStack {
                VStack {
                    Spacer()
//                    YamCapsuleLabel(title: DateConverter.getDateString(from: event.organization.date),
//                                    fontSize: 15)
                    Spacer()
                }
                .background(GradientPack.orangePurple)
                .cornerRadius(SizePack.coreCornerRadius)

                VStack {
                    Spacer()
                        Button {
                            isActiveEventLocationView.toggle()
                        } label: {
//                            YamCapsuleLabel(title: PlaceHandler.handlePlace(event.organization.place),
//                                            fontSize: 15)
                        }
                    Spacer()
                }
                .background(GradientPack.purpleIndigo)
                .cornerRadius(SizePack.coreCornerRadius)
            }
            .frame(maxHeight: UIScreen.main.bounds.height / 2)

            // contact
            Button {
                if let url = URL(string: event.organization.link) {
                    UIApplication.shared.open(url)
                }
            } label: {
                HStack {
                    Spacer()
//                    YamCapsuleLabel(title: "контакт организатора")
                    Spacer()
                }
                .background(GradientPack.purpleIndigo)
                .cornerRadius(SizePack.coreCornerRadius)
            }

        }
        .padding()
        .background(Color("ViewDetalGray"))
        .sheet(isPresented: $isActiveEventLocationView) {
            EventLocationView(event: event)
        }

    }
}
