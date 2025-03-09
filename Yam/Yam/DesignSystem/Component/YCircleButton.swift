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
                imageSize: Const.buttonSize,
                cornerRadius: Const.buttonCornerRadius,
                background: Gradients.purpleIndigo
            )
        }
    }

}

#Preview {
    YCircleButton(imageName: "xmark", completion: {})
}
