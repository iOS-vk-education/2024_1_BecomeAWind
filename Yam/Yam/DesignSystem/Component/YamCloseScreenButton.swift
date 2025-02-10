import SwiftUI

struct YamCloseScreenButton: View {
    let clos: () -> ()

    var body: some View {
        Button {
            clos()
        } label: {
            Image(systemName: "xmark.app.fill")
                .resizable()
                .frame(width: SizePack.screenWidth * 0.07,
                       height: SizePack.screenWidth * 0.07)
                .tint(GradientPack.purpleIndigo)
        }
    }
}

#Preview {
    YamCloseScreenButton {}
}
