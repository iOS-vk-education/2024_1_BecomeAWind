import SwiftUI

struct EventsView: View {
    let events: [Event]

    var body: some View {
        TabEvent(events: events)
    }
}

struct TabEvent: View {
    let events: [Event]

    var body: some View {
        TabView {
            ForEach(events) { event in
//                EventCard(event: event)
                Text(event.link)
            }
        }
        .tabViewStyle(.page)
        .cornerRadius(30)
        .padding(.bottom, 30)
    }
}
