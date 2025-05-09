import SwiftUI

struct RectText<Background: ShapeStyle>: View {

    let text: String
    let font: Font
    let background: Background

    init(text: String,
         font: Font,
         background: Background = Gradient.purpleIndigo) {
        self.text = text
        self.font = font
        self.background = background
    }

    var body: some View {
        Text(text)
            .padding()
            .font(font)
            .foregroundColor(.white)
            .background(
                RoundedRectangle(cornerRadius: Const.cornerRadius)
                    .fill(background)
            )
    }
    
}

#Preview {
    RectText(
        text: "текст text text",
        font: FontManager.def,
        background: .purple
    )
}
