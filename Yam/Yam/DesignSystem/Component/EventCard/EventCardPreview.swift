import SwiftUI

struct EventCardPreview: View {

    let image: UIImage

    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFill()
            .frame(
                width: Const.screenWidth - ProfileConst.sideSpace * 2,
                height: Const.screenHeight * 0.5
            )
    }

}
