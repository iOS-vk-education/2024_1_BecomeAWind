import SwiftUI
import MapKit

struct ProfileEventCard: View {

    @ObservedObject var viewModel: ProfileViewModel

    let image: UIImage
    let title: String
    let seats: String
    let link: String
    let date: String
//    let geopoint: CLLocation

    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                /// preview
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: Const.screenWidth - ProfileConst.sideSpace * 2,
                        height: Const.screenHeight * 0.5
                    )

                /// title
                VStack {
                    YCapsuleLabel(
                        title: title,
                        font: ProfileConst.capsuleLabelFont,
                        background: .thinMaterial)
                    .padding(.horizontal, Const.sideSpace)


                    HStack {
                        /// date and time
                        YCapsuleLabel(
                            title: date,
                            font: ProfileConst.capsuleLabelFont,
                            background: .thinMaterial
                        )

                        /// seats
                        YCapsuleLabel(
                            title: seats,
                            font: ProfileConst.capsuleLabelFont,
                            background: .thinMaterial
                        )

                        /// place
                        ProfileVStack {
                            YCircleButton(imageName: "location") {
                                print("place opened")
                            }
                        }

                        /// link
                        ProfileVStack {
                            YCircleButton(imageName: "link") {
                                viewModel.openLink(link)
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
        .alert(
            "указана неверная ссылка",
            isPresented: $viewModel.invalidLink
        ) {
            Button("ок", role: .cancel) { }
        }
    }

}

#Preview {
    ProfileEventCard(
        viewModel: ProfileViewModel(),
        image: UIImage(named: "football")!,
        title: "игра в футбол 111 на 11 игра в футбол 1 на 11 и d.",
        seats: "9999/9999",
        link: "www",
        date: "09.11.2025\n18:30"
    )
}
