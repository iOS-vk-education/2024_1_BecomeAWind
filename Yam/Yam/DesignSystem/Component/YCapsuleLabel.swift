import SwiftUI

struct YCapsuleLabel<Background: ShapeStyle>: View {
    let title: String
    let font: Font
    let background: Background

    init(title: String,
         font: Font,
         background: Background = Gradients.purpleIndigo) {
        self.title = title
        self.font = font
        self.background = background
    }

    var body: some View {
        Text(title)
            .padding()
            .font(font)
            .foregroundColor(Colors.white)
            .background(
                RoundedRectangle(cornerRadius: Const.cornerRadius)
                    .fill(background)
            )
    }
    
}

#Preview {
    YCapsuleLabel(
        title: "текст",
        font: FontManager.def,
        background: .purple
    )
}
