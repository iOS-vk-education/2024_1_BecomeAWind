import SwiftUI

struct GradientImage: View {
    let imageName: String
    let imageSize: CGFloat
    let cornerRadius: CGFloat
    let background: LinearGradient?

    init(imageName: String,
         imageSize: CGFloat,
         cornerRadius: CGFloat,
         background: LinearGradient? = nil) {
        self.imageName = imageName
        self.imageSize = imageSize
        self.cornerRadius = cornerRadius
        self.background = background ?? nil
    }

    var body: some View {
        Image(systemName: imageName)
            .resizable()
            .padding(10)
            .frame(width: imageSize, height: imageSize)
            .foregroundColor(Colors.white)
            .background(background ?? Gradients.clear)
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
