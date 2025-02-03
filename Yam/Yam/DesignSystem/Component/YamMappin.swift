import SwiftUI

struct YamMappin: View {
    var body: some View {
        GradientImage(imageName: "mappin.circle",
                      imageSize: SizePack.smallImageSize,
                      background: GradientPack.purpleIndigo)
    }
}

#Preview {
    YamMappin()
}
