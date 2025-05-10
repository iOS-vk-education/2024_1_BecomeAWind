import SwiftUI

struct VerticalSpace: View {

    let height: CGFloat

    var body: some View {
        Rectangle()
            .frame(height: height)
            .foregroundColor(.clear)
            .listRowSeparator(.hidden)
    }
}

#Preview {
    VerticalSpace(height: 100)
}
