import SwiftUI

struct GradientLoader: View {
    let size: CGFloat
    let background: LinearGradient?

    init(size: CGFloat, background: LinearGradient? = nil) {
        self.size = size
        self.background = background ?? nil
    }

    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: size, height: size)
                .background(background ?? Gradients.clear)
                .cornerRadius(SizePack.coreCornerRadius)
            ProgressView()
        }
    }
}

#Preview {
    GradientLoader(size: 50, background: Gradients.purpleIndigo)
}
