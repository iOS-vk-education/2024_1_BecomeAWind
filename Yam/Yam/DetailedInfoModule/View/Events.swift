import SwiftUI

struct Events: View {
    var body: some View {
        TabEvent()
    }
}

struct TabEvent: View {
    @StateObject private var viewModel = EventViewModel()

    var body: some View {
        TabView {
            ForEach(viewModel.events) { event in
                EventCard(event: event)
            }
        }
        .tabViewStyle(.page)
        .cornerRadius(30)
        .padding(.bottom, 30)
    }
}

#Preview {
    Events()
}
