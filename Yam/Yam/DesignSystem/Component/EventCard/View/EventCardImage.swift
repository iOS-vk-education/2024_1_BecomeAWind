import SwiftUI

struct EventCardImage: View {

    let path: String

    var body: some View {
        ImageDownloader(path: path)
            .scaledToFill()
            .frame(
                width: Const.screenWidth - EventsConst.sideSpace * 2,
                height: Const.screenHeight * 0.5
            )
    }

}

