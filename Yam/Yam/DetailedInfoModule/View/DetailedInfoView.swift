import SwiftUI

struct DetailedInfoView: View {
    let event: Event

    var body: some View {
        VStack {
            HeaderView()
            Events()
        }
        .background(ColorsPack.black)
    }
}
