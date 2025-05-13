import SwiftUI

struct BuildEventVStack<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        VStack {
            content
        }
        .background(.thinMaterial)
        .cornerRadius(Const.cornerRadius)
        .padding(.horizontal)
        .padding(.bottom)
    }
}
