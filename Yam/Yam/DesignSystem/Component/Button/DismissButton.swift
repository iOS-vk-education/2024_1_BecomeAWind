import SwiftUI

struct DismissButton: View {

    let action: () -> Void

    var body: some View {
        YCircleButton(
            imageName: "xmark",
            background: Gradient.pinkIndigo
        ) {
            action()
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topTrailing
        )
        .padding([.trailing, .top], Const.sideSpace)
    }
    
}

#Preview {
    DismissButton(action: {})
}
