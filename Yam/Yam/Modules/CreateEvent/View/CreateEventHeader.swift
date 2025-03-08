import SwiftUI

struct CreateEventHeader: View {
    @Binding var isActiveCreateEventView: Bool

    var body: some View {
        ZStack {
//            YamText("новый ивент",
//                         fontSize: SizePack.headerTextFontSize)
            HStack {
                Spacer()
                YamCloseScreenButton {
                    isActiveCreateEventView.toggle()
                }
            }
            .padding(.trailing)

        }
    }
}

#Preview {
    @Previewable @State var bool = true
    CreateEventHeader(isActiveCreateEventView: $bool)
}
