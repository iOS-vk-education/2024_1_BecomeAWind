import SwiftUI

extension View {

    func fixedSizeView<Background: ShapeStyle>(background: Background = Gradient.purpleIndigo) -> some View {
        self
            .padding()
            .frame(maxWidth: .infinity, alignment: .center)
            .background(background)
            .clipShape(
                RoundedRectangle(cornerRadius: Const.cornerRadius)
            )
            .padding(.horizontal)
    }

    func fixedSizeText<Background: ShapeStyle>(background: Background = Gradient.purpleIndigo) -> some View {
        self
            .padding()
            .frame(maxWidth: .infinity, alignment: .center)
            .font(Const.buttonFont)
            .foregroundColor(.white)
            .background(background)
            .clipShape(
                RoundedRectangle(cornerRadius: Const.cornerRadius)
            )
            .padding(.horizontal)
    }

}
