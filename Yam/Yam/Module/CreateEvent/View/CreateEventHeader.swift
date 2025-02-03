import SwiftUI

struct CreateEventHeader: View {
    var body: some View {
        YamWhiteText(text: "новый ивент",
                     fontSize: SizePack.headerTextFontSize)
        .padding(.top)
    }
}

#Preview {
    CreateEventHeader()
        .background(ColorPack.black)
}
