import SwiftUI

struct EventOnMap: View {

    let imagePath: String

    var body: some View {
        ImageDownloader(path: imagePath)
            .scaledToFill()
            .frame(width: Const.eventImageSize, height: Const.eventImageSize)
            .clipped()
            .cornerRadius(Const.cornerRadius)
    }

}

#Preview {
    EventOnMap(imagePath: "path")
}
