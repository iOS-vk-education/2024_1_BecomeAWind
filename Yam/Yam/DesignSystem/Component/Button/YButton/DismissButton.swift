import SwiftUI

struct DismissButton: View {

    let action: () -> Void

    var body: some View {
        RectImageButton(imageName: "xmark",
                        imageScale: 0.4,
                        background: .thinMaterial,
                        action: action)
    }

}

#Preview {
    DismissButton(action: {})
}
