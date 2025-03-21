import SwiftUI

struct YSquareButton: View {
    var imageName: String
    var completion: () -> Void

    var body: some View {
        Button {
            completion()
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
    YSquareButton(imageName: "xmark", completion: {})
}
