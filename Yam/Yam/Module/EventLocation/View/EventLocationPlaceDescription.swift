import SwiftUI

struct EventLocationPlaceDescription: View {

    let title: String

    var body: some View {
        RectText(
            text: title,
            font: Const.placeDescriptionFont,
            background: .thinMaterial
        )
        .frame(maxWidth: Const.screenWidth / 2)
    }

}

#Preview {
    EventLocationPlaceDescription(title: "text")
}
