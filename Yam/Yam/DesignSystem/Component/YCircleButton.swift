import SwiftUI

struct YCircleButton<Background: ShapeStyle>: View {
    var imageName: String
    var background: Background
    var action: () -> Void

    init(
        imageName: String,
        background: Background = Gradient.purpleIndigo,
        action: @escaping () -> Void
    ) {
        self.imageName = imageName
        self.background = background
        self.action = action
    }

    var body: some View {
        Button {
            action()
        } label: {
            GradientImage(set: GradientImage.ImageSet(
                name: imageName,
                size: Const.circleButtonSize,
                cornerRadius: Const.circleButtonCornerRadius,
                background: background)
            )
        }
        .buttonStyle(.plain)
    }

}

struct YCircleButtonSecond<Background: ShapeStyle>: View {
    var imageName: String
    var background: Background
    var action: () -> Void

    init(
        imageName: String,
        background: Background = Gradient.purpleIndigo,
        action: @escaping () -> Void
    ) {
        self.imageName = imageName
        self.background = background
        self.action = action
    }

    var body: some View {
        Button {
            action()
        } label: {
            GradientImage(set: GradientImage.ImageSet(
                name: imageName,
                size: Const.squareButtonSize,
                cornerRadius: Const.squareButtonCornerRadius,
                background: background)
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    YCircleButton(imageName: "xmark", action: {})
}
