import SwiftUI

struct CreateEventVStack<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        VStack {
            content
        }
        .background(ColorPack.gray1)
        .cornerRadius(SizePack.coreCornerRadius)
        .padding(.horizontal, SizePack.coreSideSpacing)
        .padding(.bottom)
    }
}
