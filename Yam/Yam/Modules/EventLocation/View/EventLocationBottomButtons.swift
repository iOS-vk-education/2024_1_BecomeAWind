import SwiftUI

struct EventLocationBottomButtons: View {

    let showEventAction: () -> Void
    let showUserAction: () -> Void

    var body: some View {
        HStack {
            Button {
                showEventAction()
            } label: {
                CapsuleLabel(
                    title: "показать ивент",
                    font: Const.buttonFont
                )
            }

            CircleButton(imageName: "location") {
                showUserAction()
            }
        }
    }

}

#Preview {
    EventLocationBottomButtons(showEventAction: {}, showUserAction: {})
}
