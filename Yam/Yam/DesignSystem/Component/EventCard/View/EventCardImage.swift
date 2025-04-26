import SwiftUI
import SDWebImageSwiftUI

struct EventCardImage: View {

    let path: String

    @State private var loadFail = false

    var body: some View {
        if loadFail {
            DefaultEventImage()
        } else {
            WebImage(url: URL(string: path))
                .onFailure { error in
                    loadFail = true
                    Logger.Events.loadImageFail(by: path, with: error)
                }
                .resizable()
                .scaledToFill()
                .frame(
                    width: Const.screenWidth - EventsConst.sideSpace * 2,
                    height: Const.screenHeight * 0.5
                )
        }
    }
}

struct DefaultEventImage: View {

    var body: some View {
        Image(uiImage: UIImage(named: "loginScreen") ?? UIImage())
            .resizable()
            .scaledToFill()
            .frame(
                width: Const.screenWidth - EventsConst.sideSpace * 2,
                height: Const.screenHeight * 0.5
            )
    }

}
