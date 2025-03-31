import SwiftUI

struct NavBarStack<Content: View>: View {

    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        VStack {
            HStack {
                content
            }
            .padding()
            .frame(height: Const.navBarHeight)
            .background(.thinMaterial)
            .cornerRadius(
                Const.cornerRadius,
                corners: [.bottomLeft, .bottomRight]
            )
            Spacer()
        }
    }
    
}
