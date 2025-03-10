import SwiftUI

struct ProfileVStack<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        VStack {
            content
        }
        .padding(10)
        .background(.thinMaterial)
        .cornerRadius(Const.cornerRadius)
    }
    
}

#Preview {
    ProfileVStack {
        Button {
            
        } label: {
            Text("1")
        }
    }
}
