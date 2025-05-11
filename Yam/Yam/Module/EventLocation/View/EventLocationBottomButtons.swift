import SwiftUI

struct EventLocationBottomButtons: View {

    @Environment(\.dismiss) var dismiss
    let showEvent: () -> Void
    let showUser: () -> Void

    var body: some View {
        VStack {
            Button {
                showEvent()
            } label: {
                UnlimitedText(text: "ивент",
                              background: Gradient.indigoPurple)
            }

            HStack {
                LocationButton {
                    showUser()
                }

                DismissButton {
                    dismiss()
                }
            }
        }
    }

}

#Preview {
    EventLocationBottomButtons(showEvent: {}, showUser: {})
}
