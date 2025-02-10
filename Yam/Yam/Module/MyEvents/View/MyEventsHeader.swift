import SwiftUI

struct MyEventsHeader: View {
    let title: String

    var body: some View {
        YamWhiteText(text: title)
    }
}

#Preview {
    MyEventsHeader(title: "твои ивенты")
}
