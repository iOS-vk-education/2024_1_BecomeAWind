import SwiftUI
import MapKit

struct ProfileEventCard: View {

    @ObservedObject var viewModel: ProfileViewModel

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

                /// title
                VStack {
                    YCapsuleLabel(
                        title: event.title,
                        font: ProfileConst.capsuleLabelFont,
                        background: .thinMaterial)
                    .padding(.horizontal, Const.sideSpace)


                    HStack {
                        /// date and time
                        YCapsuleLabel(
                            title: viewModel.getDateString(
                                from: event.date
                            ),
                            font: ProfileConst.capsuleLabelFont,
                            background: .thinMaterial
                        )

                        /// seats
                        YCapsuleLabel(
                            title: viewModel.getSeatsString(
                                from: event.seats
                            ),
                            font: ProfileConst.capsuleLabelFont,
                            background: .thinMaterial
                        )

                        /// place
                        ProfileVStack {
                            YCircleButton(imageName: "location") {
                                viewModel.toggleEventLocation()
                            }
                        }
                        .fullScreenCover(
                            isPresented: $viewModel.isActiveEventLocation
                        ) {
                            EventLocationView(event: event)
                        }

                        /// link
                        ProfileVStack {
                            YCircleButton(imageName: "link") {
                                viewModel.openLink(event.link)
                            }
                        }
                    }
                    .padding([.horizontal, .bottom], Const.sideSpace)
                }
            }
        }
        .frame(
            width: Const.screenWidth - ProfileConst.sideSpace * 2,
            height: Const.screenHeight * 0.5
        )
        .cornerRadius(Const.cornerRadius)
//        .alert(
//            "указана неверная ссылка",
//            isPresented: $viewModel.invalidLink
//        ) {
//            Button("ок", role: .cancel) { }
//        }
    }

}

#Preview {
    ProfileEventCard(
        viewModel: ProfileViewModel(),
        event: Event(
            image: UIImage(named: "football")!,
            title: "event",
            seats: Seats(busy: 0, all: 100),
            link: "www",
            date: Date(),
            geopoint: CLLocation()
        )
    )
}
