import SwiftUI

struct EventCardTitleLabel: View {

    let title: String

    var body: some View {
        YCapsuleLabel(
            title: title,
            font: ProfileConst.capsuleLabelFont,
            background: .thinMaterial)
        .padding(.horizontal, Const.sideSpace)
    }

}
