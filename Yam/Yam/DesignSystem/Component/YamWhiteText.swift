import SwiftUI

struct YamWhiteText: View {
    let text: String
    let fontWeight: YamFontWeight
    let fontSize: CGFloat

    private var font: Font

    init(text: String,
         fontWeight: YamFontWeight = .extrabold,
         fontSize: CGFloat = SizePack.coreFontSize) {
        self.text = text
        self.fontWeight = fontWeight
        self.fontSize = fontSize

        font = FontManager.getFont(with: fontWeight, and: fontSize)
    }

    var body: some View {
        Text(text)
            .foregroundColor(ColorPack.white)
            .font(font)
    }
}

#Preview {
    YamWhiteText(text: "текст", fontSize: 40)
        .padding()
        .background(ColorPack.black)
}
