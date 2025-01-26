import SwiftUI

struct YamImage: View {
    let image: UIImage
    let size: CGFloat

    init(image: UIImage, size: CGFloat = BaseSizesPack.defaultImageSize) {
        self.image = image
        self.size = size
    }

    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFill()
            .frame(width: size, height: size)
            .clipped()
            .cornerRadius(BaseSizesPack.coreCornerRadius)
    }
}

#Preview {
    YamImage(image: UIImage(named: "defaulteventimage")!, size: 200)
}
