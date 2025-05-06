import SwiftUI

struct MapEventAnnotation: View {

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
    MapEventAnnotation(imagePath: "path")
}
