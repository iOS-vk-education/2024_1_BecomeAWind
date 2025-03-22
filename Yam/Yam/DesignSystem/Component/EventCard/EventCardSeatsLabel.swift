import SwiftUI

struct EventCardSeatsLabel: View {

    let seatsTitle: String

    var body: some View {
        YCapsuleLabel(
            title: seatsTitle,
            font: ProfileConst.capsuleLabelFont,
            background: .thinMaterial
        )
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        )
        .padding([.leading, .top], Const.sideSpace)
    }

}
