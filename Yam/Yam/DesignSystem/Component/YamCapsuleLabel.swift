import SwiftUI

struct YamCapsuleLabel: View {
    let title: String
    let fontWeight: YamFontWeight
    let fontSize: CGFloat
    let background: LinearGradient

    private var font: Font

    init(title: String,
         fontWeight: YamFontWeight = .extrabold,
         fontSize: CGFloat = SizePack.coreFontSize,
         background: LinearGradient = GradientPack.purpleIndigo) {
        self.title = title
        self.fontWeight = fontWeight
        self.fontSize = fontSize
        self.background = background

        font = FontManager.getFont(with: fontWeight, and: fontSize)
    }

    var body: some View {
        Text(title)
            .padding()
            .font(font)
            .foregroundColor(ColorPack.white)
            .background(background)
            .cornerRadius(SizePack.coreCornerRadius)
    }
}

#Preview {
    YamCapsuleLabel(title: "текст", background: GradientPack.purpleIndigo)
}
