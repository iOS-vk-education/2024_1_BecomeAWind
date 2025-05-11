import SwiftUI

struct OpenProfileButton: View {

    let action: () -> Void

    var body: some View {
        RectImageButton(imageName: "person.crop.circle",
                        imageScale: 0.5,
                        background: .thinMaterial) {
            action()
        }
    }


}

#Preview {
    OpenProfileButton(action: {})
}
