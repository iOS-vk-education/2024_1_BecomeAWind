import SwiftUI

struct LocationButton: View {

    let action: () -> Void

    var body: some View {
        RectImageButton(imageName: "scope",
                        imageScale: 0.6,
                        background: .thinMaterial,
                        action: action)
    }

}

#Preview {
    LocationButton(action: {})
}
