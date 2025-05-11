import SwiftUI

struct EventsBottomSpace: View {

    var body: some View {
        VerticalSpace(height: Const.screenWidth * 0.17 / 2)
        TabBarSpace()
    }

}

#Preview {
    EventsBottomSpace()
}
