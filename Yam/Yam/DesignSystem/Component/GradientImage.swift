import SwiftUI

struct GradientImage: View {
    let imageName: String
    let imageSize: CGFloat
    let background: LinearGradient?

    init(imageName: String,
         imageSize: CGFloat,
         background: LinearGradient? = nil) {
        self.imageName = imageName
        self.imageSize = imageSize
        self.background = background ?? nil
    }

    var body: some View {
        Image(systemName: imageName)
            .resizable()
            .frame(width: imageSize, height: imageSize)
            .padding(10)
            .foregroundColor(ColorPack.white)
            .background(background ?? GradientPack.clear)
            .cornerRadius(SizePack.coreCornerRadius)
    }
}

#Preview {
    GradientImage(imageName: "mappin.circle", imageSize: 50)
}
