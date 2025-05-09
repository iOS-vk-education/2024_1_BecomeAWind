import SwiftUI

struct CapsuleButton<Background: ShapeStyle>: View {

    let title: String
    let background: Background
    let action: () -> Void

    init(title: String, background: Background = Gradient.purpleIndigo, action: @escaping () -> Void) {
        self.title = title
        self.background = background
        self.action = action
    }

    var body: some View {
        Button {
            action()
        } label: {
            RectText(
                text: title,
                font: Const.buttonFont,
                background: background
            )
        }
    }

}
