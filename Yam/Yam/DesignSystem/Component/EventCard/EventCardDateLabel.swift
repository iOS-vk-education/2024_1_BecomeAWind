import SwiftUI

struct EventCardDateLabel: View {

    let title: String

    var body: some View {
        YCapsuleLabel(
            title: title,
            font: ProfileConst.capsuleLabelFont,
            background: .thinMaterial)
        .padding(.bottom, Const.sideSpace)
    }

}
