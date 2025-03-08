import SwiftUI

struct YamCapsuleLabel: View {
    let title: String
    let font: Font
    let background: LinearGradient

    init(title: String,
         font: Font,
         background: LinearGradient = GradientPack.purpleIndigo) {
        self.title = title
        self.font = font
        self.background = background
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
    YamCapsuleLabel(
        title: "текст",
        font: Fonts.def,
        background: GradientPack.purpleIndigo
    )
}
