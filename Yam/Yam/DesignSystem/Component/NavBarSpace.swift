import SwiftUI

struct NavBarSpace: View {

    var body: some View {
        Rectangle()
            .frame(height: Const.navBarHeight)
            .foregroundColor(.clear)
            .listRowSeparator(.hidden)
    }

}

#Preview {
    NavBarSpace()
}
