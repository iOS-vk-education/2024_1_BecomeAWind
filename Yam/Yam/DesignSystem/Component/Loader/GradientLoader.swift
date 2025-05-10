import SwiftUI

struct GradientLoader<Background: ShapeStyle>: View {
    let size: CGFloat
    let background: Background

    init(background: Background = Gradient.purpleIndigo, size: CGFloat = Const.circleButtonSize) {
        self.background = background
        self.size = size
    }

    var body: some View {
        ZStack {
            Rectangle()
                .fill(background)
                .frame(width: size, height: size)
                .cornerRadius(Const.cornerRadius)
            ProgressView()
        }

    }
}
