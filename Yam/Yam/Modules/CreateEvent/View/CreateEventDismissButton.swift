import SwiftUI

struct CreateEventDismissButton: View {
    var completion: () -> Void

    var body: some View {
        HStack {
            Spacer()
            Button {
                completion()
            } label: {
                GradientImage(
                    imageName: "xmark",
                    imageSize: CreateEventConst.dismissButtonSize,
                    cornerRadius: CreateEventConst.dismissButtonCornerRadius,
                    background: Gradients.purpleIndigo
                )
            }
            .padding(
                .trailing,
                CreateEventConst.dismissButtonSideSpace
            )
        }
    }
}

#Preview {
    CreateEventDismissButton(completion: {})
}
