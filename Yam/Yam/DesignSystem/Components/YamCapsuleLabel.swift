import SwiftUI

struct YamCapsuleLabel: View {
    let title: String
    let font: Font
    let background: LinearGradient

    init(title: String,
         font: Font,
         background: LinearGradient = Gradients.purpleIndigo) {
        self.title = title
        self.font = font
        self.background = background
    }

    var body: some View {
        Text(title)
            .padding()
            .font(font)
            .foregroundColor(Colors.white)
            .background(background)
            .cornerRadius(SizePack.coreCornerRadius)
    }
}

#Preview {
    YamCapsuleLabel(
        title: "текст",
        font: FontManager.def,
        background: Gradients.purpleIndigo
    )
}
