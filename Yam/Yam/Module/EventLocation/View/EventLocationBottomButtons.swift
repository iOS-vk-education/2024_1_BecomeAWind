import SwiftUI

struct EventLocationBottomButtons: View {

    let showEvent: () -> Void
    let showUser: () -> Void

    var body: some View {
        VStack {
            LocationButton {
                showUser()
            }

            Button {
                showEvent()
            } label: {
                UnlimitedText(text: "ивент",
                              background: Gradient.indigoPurple)
            }
        }
    }

}

#Preview {
    EventLocationBottomButtons(showEvent: {}, showUser: {})
}
