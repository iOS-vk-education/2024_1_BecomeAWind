import SwiftUI

struct RectTextButton<Background: ShapeStyle>: View {

    let text: String
    let font: Font
    let background: Background
    let action: () -> Void

    init(text: String,
         font: Font = Const.buttonFont,
         background: Background = Gradient.purpleIndigo,
         action: @escaping () -> Void) {
        self.text = text
        self.font = font
        self.background = background
        self.action = action
    }

    var body: some View {
        Button {
            action()
        } label: {
            RectText(text: text,
                     font: font,
                     background: background)
        }
    }

}

#Preview {
    RectTextButton(text: "text text text",
                   font: Const.buttonFont,
                   background: Gradient.purpleIndigo,
                   action: {})
}
