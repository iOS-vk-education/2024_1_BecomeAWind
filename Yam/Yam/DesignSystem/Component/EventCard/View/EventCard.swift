import SwiftUI
import MapKit

struct EventCard: View {

    let viewModel: EventCardViewModelProtocol
    let event: Event
    let eventType: EventType
    @State var isActiveActionButton = false

    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                /// image
                EventCardImage(path: event.imagePath)

                /// buttons
                HStack {
                    /// place
                    EventCardButton(imageName: "location", background: Gradient.purpleIndigo) {
                        viewModel.showLocation(of: event)
                    }

                    /// link
                    EventCardButton(imageName: "link", background: Gradient.purpleIndigo) {
                        viewModel.open(link: event.link)
                    }

                    /// action button
                    if !isActiveActionButton {
                        switch eventType {
                        case .my:
                            EventCardButton(imageName: "gearshape", background: Gradient.pinkIndigo) {
                                viewModel.showBuildEvent(for: event)
                            }
                        case .added:
                            EventCardButton(imageName: "xmark", background: Gradient.pinkIndigo) {
                                Task {
                                    isActiveActionButton = true

                                    if await viewModel.handleSubscribeButton(event: event,
                                                                             eventType: eventType) {
                                        await viewModel.updateEvent(eventID: event.id)
                                    }

                                    isActiveActionButton = false
                                }
                            }
                        case .notAdded:
                            EventCardButton(imageName: "plus", background: Gradient.greenIndigo) {
                                Task {
                                    isActiveActionButton = true

                                    if await viewModel.handleSubscribeButton(event: event,
                                                                             eventType: eventType) {
                                        await viewModel.updateEvent(eventID: event.id)
                                    }

                                    isActiveActionButton = false
                                }
                            }
                        }
                    } else {
                        EventCardLoadingButton(
                            background: eventType == .notAdded
                            ? Gradient.greenIndigo
                            : Gradient.pinkIndigo
                        )
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
