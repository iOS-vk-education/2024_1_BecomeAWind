import SwiftUI

struct YSquareButton: View {
    var imageName: String
    var completion: () -> Void

    var body: some View {
        Button {
            completion()
        } label: {
            GradientImage(
                imageName: imageName,
                imageSize: Const.squareButtonSize,
                cornerRadius: Const.squareButtonCornerRadius,
                background: Gradients.purpleIndigo
            )
        }
        .buttonStyle(.plain)
    }

}

#Preview {
    YSquareButton(imageName: "xmark", completion: {})
}
