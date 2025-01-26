import SwiftUI

struct DetailedInfoView: View {
    let events: [Event]

    var body: some View {
        VStack {
//            HeaderView()
            EventsView(events: events)
        }
        .background(ColorsPack.black)
    }
}
