import SwiftUI

struct Delme: View {
    @State var text = ""
    var body: some View {
        TextField("", text: $text)
            .background(.indigo)
    }
}

#Preview {
    Delme()
}
