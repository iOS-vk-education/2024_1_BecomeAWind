import SwiftUI

struct MakeEventVStack<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        VStack {
            content
        }
        .background(Colors.gray)
        .cornerRadius(Const.cornerRadius)
        .padding(.horizontal, Const.sideSpace)
        .padding(.bottom)
    }
}
