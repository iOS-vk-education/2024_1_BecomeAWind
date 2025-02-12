import SwiftUI

struct MyEventsHeader: View {
    let title: String

    var body: some View {
        YamText(title)
    }
}

#Preview {
    MyEventsHeader(title: "твои ивенты")
}
