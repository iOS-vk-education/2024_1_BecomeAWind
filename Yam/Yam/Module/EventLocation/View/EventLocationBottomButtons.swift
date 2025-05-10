import SwiftUI

struct EventLocationBottomButtons: View {

    let showEvent: () -> Void
    let showUser: () -> Void

    var body: some View {
        VStack {
            LocationButton {
                showUser()
            }

            RectTextButton(text: "ивент",
                           background: Gradient.indigoPurple) {
                showEvent()
            }
        }
    }

}

#Preview {
    EventLocationBottomButtons(showEvent: {}, showUser: {})
}
