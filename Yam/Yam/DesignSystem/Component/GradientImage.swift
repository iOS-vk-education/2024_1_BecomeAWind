import SwiftUI

struct GradientImage<Background: ShapeStyle>: View {
    let imageName: String
    let imageSize: CGFloat
    let cornerRadius: CGFloat
    let background: Background

    init(imageName: String,
         imageSize: CGFloat,
         cornerRadius: CGFloat,
         background: Background = Colors.clear) {
        self.imageName = imageName
        self.imageSize = imageSize
        self.cornerRadius = cornerRadius
        self.background = background
    }

    var body: some View {
        Image(systemName: imageName)
            .resizable()
            .padding(10)
            .frame(width: imageSize, height: imageSize)
            .foregroundColor(Colors.white)
            .background(background)
            .cornerRadius(cornerRadius)
    }
    
}

#Preview {
    GradientImage(
        imageName: "mappin.circle",
        imageSize: 40,
        cornerRadius: Const.cornerRadius,
        background: Gradients.purpleIndigo
    )
}
