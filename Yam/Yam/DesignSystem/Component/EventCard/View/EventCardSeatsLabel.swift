import SwiftUI

struct EventCardSeatsLabel: View {

    let seatsTitle: String

    var body: some View {
        UnlimitedText(
            text: seatsTitle,
            font: EventsConst.capsuleLabelFont,
            background: .thinMaterial
        )
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        )
        .padding([.leading, .top])
    }

}
