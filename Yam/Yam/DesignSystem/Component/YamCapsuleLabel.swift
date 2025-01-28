import SwiftUI

struct YamCapsuleLabel: View {
    let title: String
    let fontSize: CGFloat
    let fontWeight: Font.Weight
    let background: LinearGradient?

    init(title: String,
         fontSize: CGFloat = 20,
         fontWeight: Font.Weight = .heavy,
         background: LinearGradient? = nil) {
        self.title = title
        self.fontSize = fontSize
        self.fontWeight = fontWeight
        self.background = background ?? nil
    }

    var body: some View {
        Text(title)
            .padding()
            .font(Font.system(size: fontSize))
            .fontWeight(fontWeight)
            .foregroundColor(ColorPack.white)
            .background(background ?? GradientPack.clear)
            .cornerRadius(SizePack.coreCornerRadius)
    }
}

#Preview {
    YamCapsuleLabel(title: "Текст", background: GradientPack.purpleIndigo)
}
