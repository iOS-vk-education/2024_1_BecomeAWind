import SwiftUI
import MapKit

struct EventCard: View {

    let viewModel: EventCardViewModelProtocol
    let event: Event
    @Binding var eventType: EventType

    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                /// image
                EventCardImage(path: event.imagePath)

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

                    /// action button
                    switch eventType {
                    case .my:
                        EventCardButton(imageName: "gearshape", background: Gradient.pinkIndigo) {
                            viewModel.toggleAction(for: event)
                        }
                    case .added:
                        EventCardButton(imageName: "xmark", background: Gradient.pinkIndigo) {
                            Task {
                                if await viewModel.handleSubscribeButton(for: event, eventType: eventType) {
                                    eventType = .notAdded
                                }
                            }
                        }
                    case .notAdded:
                        EventCardButton(imageName: "plus", background: Gradient.greenIndigo) {
                            Task {
                                if await viewModel.handleSubscribeButton(for: event, eventType: eventType) {
                                    eventType = .added
                                }
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
