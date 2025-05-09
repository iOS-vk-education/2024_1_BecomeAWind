import SwiftUI

struct RectImageButton<Background: ShapeStyle>: View {

    let imageName: String
    let background: Background
    let action: () -> Void

    init(imageName: String,
         background: Background = Gradient.purpleIndigo,
         action: @escaping () -> Void) {
        self.imageName = imageName
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
                        .frame(width: Const.rectButtonSize * 0.6,
                               height: Const.rectButtonSize * 0.6)
                        .foregroundColor(.white)
                )
        }
    }
    
}

#Preview {
    RectImageButton(imageName: "scope",
               background: Gradient.purpleIndigo,
               action: {})
}
