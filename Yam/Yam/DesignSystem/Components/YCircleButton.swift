import SwiftUI

struct YCircleButton: View {
    var imageName: String
    var completion: () -> Void

    var body: some View {
        HStack {
            Spacer()
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
            .padding(.trailing, Const.sideSpace)
        }
    }
}

#Preview {
    YCircleButton(imageName: "xmark", completion: {})
}
