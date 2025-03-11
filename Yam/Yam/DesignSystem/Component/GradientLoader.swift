import SwiftUI

struct GradientLoader<Background: ShapeStyle>: View {
    let size: CGFloat
    let background: Background

    init(size: CGFloat, background: Background = Colors.clear) {
        self.size = size
        self.background = background
    }

    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: size, height: size)
                .background(background)
                .cornerRadius(SizePack.coreCornerRadius)
            ProgressView()
        }
    }
}

#Preview {
    GradientLoader(size: 50, background: Gradients.purpleIndigo)
}
