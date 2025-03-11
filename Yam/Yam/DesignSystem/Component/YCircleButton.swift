import SwiftUI

struct YCircleButton<Background: ShapeStyle>: View {
    var imageName: String
    var background: Background
    var completion: () -> Void

    init(
        imageName: String,
        background: Background = Gradients.purpleIndigo,
        completion: @escaping () -> Void
    ) {
        self.imageName = imageName
        self.background = background
        self.completion = completion
    }

    var body: some View {
        Button {
            completion()
        } label: {
            GradientImage(
                imageName: imageName,
                imageSize: Const.circleButtonSize,
                cornerRadius: Const.circleButtonCornerRadius,
                background: background
            )
        }
        .buttonStyle(.plain)
    }

}

#Preview {
    YCircleButton(imageName: "xmark", completion: {})
}
