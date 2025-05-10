import SwiftUI

struct EventCardDateLabel: View {

    let title: String

    var body: some View {
        RectText(
            text: title,
            font: EventsConst.capsuleLabelFont,
            background: .thinMaterial)
        .padding(.bottom, Const.sideSpace)
    }

}
