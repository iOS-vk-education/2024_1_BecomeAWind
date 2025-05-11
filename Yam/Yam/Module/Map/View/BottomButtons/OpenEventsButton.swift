import SwiftUI

struct OpenEventsButton: View {

    let action: () -> Void

    var body: some View {
        RectImageButton(imageName: "photo.stack",
                        imageScale: 0.5,
                        background: .thinMaterial) {
            action()
        }
    }

}

#Preview {
    OpenEventsButton(action: {})
}
