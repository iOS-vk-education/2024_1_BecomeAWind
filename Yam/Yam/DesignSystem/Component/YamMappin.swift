import SwiftUI

struct YamMappin: View {
    var body: some View {
        GradientImage(imageName: "paperplane.fill",
                      imageSize: SizePack.smallImageSize,
                      background: GradientPack.purpleIndigo)
    }
}

#Preview {
    YamMappin()
}
