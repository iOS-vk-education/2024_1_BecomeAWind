import SwiftUI

struct YLoader<Background: ShapeStyle>: View {
    let size: CGFloat
    let background: Background

    init(size: CGFloat, background: Background = Gradient.purpleIndigo) {
        self.size = size
        self.background = background
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

#Preview {
    YLoader(size: 50, background: Gradient.purpleIndigo)
}
