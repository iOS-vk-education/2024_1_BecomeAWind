import SwiftUI

struct YamCloseScreenButton: View {
    let clos: () -> ()

    var body: some View {
        Button {
            clos()
        } label: {
            Image(systemName: "xmark.app.fill")
                .resizable()
                .frame(width: Const.screenWidth * 0.07,
                       height: Const.screenWidth * 0.07)
                .tint(Gradients.purpleIndigo)
        }
    }
}

#Preview {
    YamCloseScreenButton {}
}
