import SwiftUI

struct EventCardTitleLabel: View {

    let title: String

    var body: some View {
        RectText(
            text: title,
            font: EventsConst.capsuleLabelFont,
            background: .thinMaterial)
        .padding(.horizontal, Const.sideSpace)
    }

}
