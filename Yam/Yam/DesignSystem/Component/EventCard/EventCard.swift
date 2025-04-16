import SwiftUI
import MapKit

struct EventCard: View {

    enum EventCardType {
        case my, external
    }

    var viewModel: EventCardViewModelProtocol
    let cardType: EventCardType
    let event: Event

    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                /// preview
                EventCardPreview(image: event.image)
 
                /// buttons
                HStack {
                    /// place
                    EventCardButton(imageName: "location", background: Gradient.purpleIndigo) {
                        viewModel.toggleLocation(for: event)
                    }

                    /// link
                    EventCardButton(imageName: "link", background: Gradient.purpleIndigo) {
                        viewModel.open(link: event.link)
                    }

                    /// third button
                    switch cardType {
                    case .my:
                        EventCardButton(imageName: "gearshape", background: Gradient.pinkIndigo) {
                            viewModel.toggleEdit(event: event)
                        }
                    case .external:
                        EventCardButton(imageName: "plus", background: Gradient.greenIndigo) {
                            viewModel.handleSubscribeButton(for: event)
                        }
                    }
                }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .topTrailing
                )
                .padding([.trailing, .top], Const.sideSpace)

                /// labels
                VStack {
                    /// seats
                    EventCardSeatsLabel(seatsTitle: viewModel.convertToString(from: event.seats))

                    /// title
                    EventCardTitleLabel(title: event.title)

                    /// date and time
                    EventCardDateLabel(title: viewModel.convertToString(from: event.date))
                }
            }
        }
        .frame(
            width: Const.screenWidth - EventsConst.sideSpace * 2,
            height: Const.screenHeight * 0.5
        )
        .cornerRadius(Const.cornerRadius)
    }

}

#Preview {

    EventCard(
        viewModel: EventsViewModel(),
        cardType: .my,
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
