import SwiftUI

struct EventLocationPlaceDescription: View {

    let title: String

    var body: some View {
        UnlimitedText(
            text: title,
            font: Const.placeDescriptionFont,
            background: .thinMaterial
        )
        .frame(maxWidth: Const.screenWidth / 2)
        .padding(.top)
    }

}

#Preview {
    EventLocationPlaceDescription(title: "text")
}
