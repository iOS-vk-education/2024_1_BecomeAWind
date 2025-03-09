import SwiftUI

struct YImage: View {
    let image: UIImage
    let size: CGFloat

    init(image: UIImage, size: CGFloat) {
        self.image = image
        self.size = size
    }

    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFill()
            .frame(width: size, height: size)
            .clipped()
            .cornerRadius(SizePack.coreCornerRadius)
    }
    
}

#Preview {
    YImage(image: UIImage(named: "default_event_image")!, size: 50)
}
