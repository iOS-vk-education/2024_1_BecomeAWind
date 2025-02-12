import SwiftUI

struct YamText: View {
    let text: String
    let fontWeight: YamFontWeight
    let fontSize: CGFloat
    let foregroundColor: Color

    private var font: Font

    init(_ text: String,
         fontWeight: YamFontWeight = .bold,
         fontSize: CGFloat = SizePack.coreFontSize,
         foregroundColor: Color = .white) {
        self.text = text
        self.fontWeight = fontWeight
        self.fontSize = fontSize
        self.foregroundColor = foregroundColor

        font = FontManager.getFont(with: fontWeight, and: fontSize)
    }

    var body: some View {
        Text(text)
            .foregroundColor(foregroundColor)
            .font(font)
    }
}

#Preview {
    YamText("текст", fontSize: 20)
}
