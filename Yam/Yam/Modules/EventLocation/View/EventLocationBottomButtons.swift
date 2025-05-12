import SwiftUI

struct EventLocationBottomButtons: View {

    let showEventAction: () -> Void
    let showUserAction: () -> Void

    var body: some View {
        HStack {
            Button {
                showEventAction()
            } label: {
                YCapsuleLabel(
                    title: "показать ивент",
                    font: Const.buttonFont
                )
            }

            YCircleButtonSecond(imageName: "location") {
                showUserAction()
            }
        }
    }

}

#Preview {
    EventLocationBottomButtons(showEventAction: {}, showUserAction: {})
}
