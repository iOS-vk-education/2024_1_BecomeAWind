import SwiftUI

struct YamText: View {
    let text: String
    let fontSize: CGFloat
    let fontWeight: Font.Weight

    init(text: String, fontSize: CGFloat = 20, fontWeight: Font.Weight = .heavy) {
        self.text = text
        self.fontSize = fontSize
        self.fontWeight = fontWeight
    }

    var body: some View {
        Text(text)
            .foregroundColor(ColorPack.white)
            .font(Font.system(size: fontSize))
            .fontWeight(fontWeight)
    }
}

#Preview {
    YamText(text: "Текст", fontSize: 30)
        .background(ColorPack.black)
}
