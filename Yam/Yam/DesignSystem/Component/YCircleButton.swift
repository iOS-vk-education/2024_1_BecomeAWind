import SwiftUI

struct YCircleButton: View {
    var imageName: String
    var completion: () -> Void

    var body: some View {
        Button {
            completion()
        } label: {
            GradientImage(
                imageName: imageName,
                imageSize: Const.circleButtonSize,
                cornerRadius: Const.circleButtonCornerRadius,
                background: Gradients.purpleIndigo
            )
        }
        .buttonStyle(.plain)
    }

}

#Preview {
    YCircleButton(imageName: "xmark", completion: {})
}
