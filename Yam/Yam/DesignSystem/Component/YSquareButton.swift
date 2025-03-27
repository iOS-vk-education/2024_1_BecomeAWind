import SwiftUI

struct YSquareButton: View {
    var imageName: String
    var action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            GradientImage(set: GradientImage.ImageSet(
                name: imageName,
                size: Const.squareButtonSize,
                cornerRadius: Const.squareButtonCornerRadius,
                background: Gradient.purpleIndigo)
            )
        }
        .buttonStyle(.plain)
    }

}

#Preview {
    YSquareButton(imageName: "xmark", action: {})
}
