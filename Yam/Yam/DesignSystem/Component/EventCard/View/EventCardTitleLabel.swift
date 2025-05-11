import SwiftUI

struct EventCardTitleLabel: View {

    let title: String

    var body: some View {
        UnlimitedText(
            text: title,
            font: EventsConst.capsuleLabelFont,
            background: .thinMaterial)
        .padding(.horizontal)
    }

}
