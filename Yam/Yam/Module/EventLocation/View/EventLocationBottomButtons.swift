import SwiftUI

struct EventLocationBottomButtons: View {

    @Environment(\.dismiss) var dismiss
    let showEvent: () -> Void
    let showUser: () -> Void

    var body: some View {
        VStack {
            HStack {
                Button {
                    showEvent()
                } label: {
                    UnlimitedText(text: "ивент",
                                  background: Gradient.indigoPurple)
                }

                LocationButton {
                    showUser()
                }
            }

            DismissButton {
                dismiss()
            }
        }
    }

}

#Preview {
    EventLocationBottomButtons(showEvent: {}, showUser: {})
}
