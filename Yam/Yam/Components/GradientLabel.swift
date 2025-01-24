import SwiftUI

struct GradientLabel: View {
    let title: String
    let fontSize: CGFloat
    let background: LinearGradient?

    init(title: String,
         fontSize: CGFloat = 20,
         background: LinearGradient? = nil) {
        self.title = title
        self.fontSize = fontSize
        self.background = background ?? nil
    }

    var body: some View {
        Text(title)
            .padding()
            .font(Font.system(size: fontSize))
            .fontWeight(.heavy)
            .foregroundColor(ColorsPack.white)
            .background(background ?? GradientsPack.clear)
            .cornerRadius(BaseSizesPack.coreCornerRadius)
    }
}

#Preview {
    GradientLabel(title: "Текст", background: GradientsPack.indigoPurple)
}
