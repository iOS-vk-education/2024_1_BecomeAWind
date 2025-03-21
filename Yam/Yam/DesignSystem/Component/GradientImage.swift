import SwiftUI

struct GradientImage<Background: ShapeStyle>: View {

    struct ImageSet {
        let name: String
        let size: CGFloat
        let cornerRadius: CGFloat
        let background: Background

        init(name: String, size: CGFloat, cornerRadius: CGFloat, background: Background = .clear) {
            self.name = name
            self.size = size
            self.cornerRadius = cornerRadius
            self.background = background
        }
    }

    let set: ImageSet

    init(set: ImageSet) {
        self.set = set
    }

    var body: some View {
        Image(systemName: set.name)
            .resizable()
            .padding(10)
            .frame(width: set.size, height: set.size)
            .foregroundColor(.white)
            .background(set.background)
            .cornerRadius(set.cornerRadius)
    }
    
}

#Preview {
    
    GradientImage(set: GradientImage.ImageSet(
        name: "mappin.circle",
        size: 40,
        cornerRadius: Const.cornerRadius,
        background: Gradient.purpleIndigo)
    )

}
