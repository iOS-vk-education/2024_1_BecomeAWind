import SwiftUI

struct CreateEventText: View {
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
            .foregroundColor(ColorsPack.white)
            .font(Font.system(size: fontSize))
            .fontWeight(fontWeight)
    }
}

#Preview {
    CreateEventText(text: "Текст", fontSize: 30)
}
