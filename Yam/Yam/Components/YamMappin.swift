import SwiftUI

struct YamMappin: View {
    var body: some View {
        GradientImage(imageName: "mappin.circle",
                      imageSize: CreateEventViewSizesPack.imageSize,
                      background: GradientsPack.purpleIndigo)
    }
}

#Preview {
    YamMappin()
}
