import SwiftUI
import MapKit

struct ProfileEventCard: View {

    let image: UIImage
    let title: String
    let seats: String
//    let link: String
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
                        width: Const.screenWidth - Const.sideSpace * 2,
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
                                print("link opened")
                            }
                        }
                    }
                    .padding([.horizontal, .bottom], Const.sideSpace)
                }
            }
            
        }
        .frame(
            width: Const.screenWidth - Const.sideSpace * 2,
            height: Const.screenHeight * 0.5
        )
        .cornerRadius(Const.cornerRadius)
    }

}

#Preview {
    ProfileEventCard(
        image: UIImage(named: "football")!,
        title: "игра в футбол 111 на 11 игра в футбол 1 на 11 и d.",
        seats: "9999/9999",
        date: "09.11.2025\n18:30"
    )
}
