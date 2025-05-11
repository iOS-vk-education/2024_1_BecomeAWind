import SwiftUI

struct CircleLabel<Background: ShapeStyle>: View {
    let count: Int
    let font: Font
    let background: Background

    init(count: Int,
         font: Font,
         background: Background = Gradient.purpleIndigo) {
        self.count = count
        self.font = font
        self.background = background
    }

    var body: some View {
        Text("\(count)")
            .padding()
            .font(font)
            .foregroundColor(.white)
            .background(
                Circle()
                    .fill(background)
            )
    }

}

#Preview {
    CircleLabel(
        count: 1,
        font: FontManager.def,
        background: .purple
    )
}
