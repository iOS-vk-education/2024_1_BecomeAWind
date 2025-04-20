import SwiftUI

struct EventLocationPlaceDescription: View {

    let title: String

    var body: some View {
        CapsuleLabel(
            title: title,
            font: Const.placeDescriptionFont,
            background: .thinMaterial
        )
        .frame(maxWidth: UIScreen.main.bounds.width / 2)
    }

}

#Preview {
    EventLocationPlaceDescription(title: "text")
}
