import SwiftUI

struct TabBarSpace: View {

    var body: some View {
        Rectangle()
            .frame(height: AuthorizedEntryConst.tabBarHeight)
            .foregroundColor(.clear)
            .listRowSeparator(.hidden)
    }

}

#Preview {
    TabBarSpace()
}
