import SwiftUI

struct EventCardDateLabel: View {

    let title: String

    var body: some View {
        CapsuleLabel(
            title: title,
            font: EventsConst.capsuleLabelFont,
            background: .thinMaterial)
        .padding(.bottom, Const.sideSpace)
    }

}
