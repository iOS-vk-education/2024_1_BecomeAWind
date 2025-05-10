import SwiftUI

struct LocationButton: View {

    let action: () -> Void

    var body: some View {
        RectImageButton(imageName: "scope",
                        background: .thinMaterial,
                        action: action)
    }

}

#Preview {
    LocationButton(action: {})
}
