import SwiftUI

struct DetailedInfoView: View {
    let events: [Event]

    var body: some View {
        VStack {
            EventsView(events: events)
        }
        .background(Colors.black)
    }
}
