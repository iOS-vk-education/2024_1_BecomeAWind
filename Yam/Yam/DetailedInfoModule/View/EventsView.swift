import SwiftUI

struct EventsView: View {
    let events: [Event]

    var body: some View {
        TabEvent(events: events)
    }
}

struct TabEvent: View {
    @StateObject private var viewModel = DetailedInfoViewModel()
    let events: [Event]

    var body: some View {
        TabView {
            ForEach(events) { event in
                EventCard(event: event)
            }
        }
        .tabViewStyle(.page)
        .cornerRadius(30)
        .padding(.bottom, 30)
    }
}

// #Preview {
//    EventsView()
// }
