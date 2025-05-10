import SwiftUI

struct RectImageButton<Background: ShapeStyle>: View {

    let imageName: String
    let imageScale: Double
    let background: Background
    let action: () -> Void

    init(imageName: String,
         imageScale: Double,
         background: Background = Gradient.purpleIndigo,
         action: @escaping () -> Void) {
        self.imageName = imageName
        self.imageScale = imageScale
        self.background = background
        self.action = action
    }

    var body: some View {
        Button {
            action()
        } label: {
            RoundedRectangle(cornerRadius: Const.rectButtonCornerRadius)
                .fill(background)
                .frame(width: Const.rectButtonSize,
                       height: Const.rectButtonSize)
                .overlay(
                    Image(systemName: imageName)
                        .resizable()
                        .frame(width: Const.rectButtonSize * imageScale,
                               height: Const.rectButtonSize * imageScale)
                        .foregroundColor(.white)
                )
        }
    }
    
}

#Preview {
    RectImageButton(imageName: "scope",
                    imageScale: 0.6,
                    background: Gradient.purpleIndigo,
                    action: {})
}
