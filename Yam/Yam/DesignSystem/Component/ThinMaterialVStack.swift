import SwiftUI

struct ThinMaterialVStack<Content: View>: View {

    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        VStack {
            content
        }
        .padding()
        .background(.thinMaterial)
        .cornerRadius(Const.cornerRadius)
        .padding()
    }

}

#Preview {
    ThinMaterialVStack(content: {})
}
