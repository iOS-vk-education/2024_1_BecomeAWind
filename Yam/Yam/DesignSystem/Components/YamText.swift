import SwiftUI

struct YamText: View {
    let text: String
    let font: Font
    let foregroundColor: Color

    init(_ text: String,
         font: Font,
         foregroundColor: Color = .white) {
        self.text = text
        self.font = font
        self.foregroundColor = foregroundColor
    }

    var body: some View {
        Text(text)
            .foregroundColor(foregroundColor)
            .font(font)
    }
}

#Preview {
    YamText("текст", font: EntryFont.tabBarItemTitleFont)
}
