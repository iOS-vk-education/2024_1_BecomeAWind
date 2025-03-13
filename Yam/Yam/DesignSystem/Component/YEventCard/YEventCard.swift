import SwiftUI
import MapKit

struct YEventCard: View {

    enum CardType {
        case myEvent
        case externalEvent
    }

    var viewModel: YEventCardProtocol
    let cardType: CardType
    let event: Event

    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                /// preview
                Image(uiImage: event.image)
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: Const.screenWidth - ProfileConst.sideSpace * 2,
                        height: Const.screenHeight * 0.5
                    )

                /// seats
                YCapsuleLabel(
                    title: viewModel.getSeatsString(
                        from: event.seats
                    ),
                    font: ProfileConst.capsuleLabelFont,
                    background: .thinMaterial
                )
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .topLeading
                )
                .padding([.leading, .top], Const.sideSpace)

                HStack {
                    /// place
                    ProfileVStack {
                        YCircleButton(imageName: "location") {
                            viewModel.toggleEventLocation(for: event)
                        }
                    }

                    /// link
                    ProfileVStack {
                        YCircleButton(imageName: "link") {
                            viewModel.openLink(event.link)
                        }
                    }

                    /// third button
                    switch cardType {
                    case .myEvent:
                        ProfileVStack {
                            YCircleButton(
                                imageName: "gearshape",
                                background: Gradients.pinkIndigo
                            ) {
                                viewModel.toggleEditEvent(for: event)
                            }
                        }
                    case .externalEvent:
                        ProfileVStack {
                            YCircleButton(
                                imageName: "plus",
                                background: Gradients.greenIndigo
                            ) {
                                viewModel.handleSubscribeButton(for: event)
                            }
                        }
                    }



                }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .topTrailing
                )
                .padding([.trailing, .top], Const.sideSpace)

                /// title
                VStack {
                    YCapsuleLabel(
                        title: event.title,
                        font: ProfileConst.capsuleLabelFont,
                        background: .thinMaterial)
                    .padding(.horizontal, Const.sideSpace)


                    /// date and time
                    YCapsuleLabel(
                        title: viewModel.getDateString(
                            from: event.date
                        ),
                        font: ProfileConst.capsuleLabelFont,
                        background: .thinMaterial
                    )
                    .padding(.bottom, Const.sideSpace)
                }
            }
        }
        .frame(
            width: Const.screenWidth - ProfileConst.sideSpace * 2,
            height: Const.screenHeight * 0.5
        )
        .cornerRadius(Const.cornerRadius)
    }

}

#Preview {
    YEventCard(
        viewModel: ProfileViewModel(),
        cardType: .myEvent,
        event: Event(
            image: UIImage(named: "football")!,
            title: "event",
            seats: Seats(busy: 0, all: 100),
            link: "www",
            date: Date(),
            place: Place(
                location: CLLocation(),
                placeDescription: "placedesc")
            )
        )
}
