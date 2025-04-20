import SwiftUI

struct MakeEventHideKeyboardButton: View {

    let action: () -> Void

    var body: some View {
        CircleButton(imageName: "arrowtriangle.down") {
            action()
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .bottomTrailing
        )
        .padding([.bottom, .trailing], Const.sideSpace)
    }

}

#Preview {
    MakeEventHideKeyboardButton(action: {})
}
