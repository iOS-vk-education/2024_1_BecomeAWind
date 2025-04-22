import SwiftUI

struct EventsView: View {

    @StateObject private var viewModel = EventsViewModel()

    var body: some View {
        NavBar(viewModel: viewModel) {
            /// events list
            List {
                Rectangle()
                    .frame(height: Const.navBarHeight)
                    .foregroundColor(.clear)
                    .listRowSeparator(.hidden)

                ForEach(
                    viewModel.activeTab == .myEvents
                     ? viewModel.myEvents
                     : viewModel.subscriptions,
                     id: \.self
                ) { event in
                    EventCard(
                        viewModel: viewModel,
                        cardType: viewModel.activeTab == .myEvents
                        ? .my
                        : .external,
                        event: event
                    )
                    .listRowSeparator(.hidden)
                }

                Rectangle()
                    .frame(height: AuthorizedEntryConst.tabBarHeight)
                    .foregroundColor(.clear)
                    .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
        }
        .fullScreenCover(
            isPresented: $viewModel.isActiveCreateEvent
        ) {
            BuildEventView()
                .onDisappear {
                    viewModel.updateEvents()
                }
        }
        .fullScreenCover(
            isPresented: $viewModel.isActiveEventLocation
        ) {
            if let event = viewModel.selectedEvent {
                EventLocationView(viewModel: EventLocationViewModel(event: event))
            }
        }
        .sheet(isPresented: $viewModel.isActiveEditEvent) {
            if let event = viewModel.selectedEvent {
                BuildEventView(
                    viewModel: BuildEventViewModel(
                        typeOfBuildEventView: .edit,
                        event: event
                    )
                )
                .onDisappear {
                    viewModel.updateEvents()
                }
            }
        }
        .alert(
            "указана неверная ссылка",
            isPresented: $viewModel.invalidLink
        ) {
            Button("ок", role: .cancel) { }
        }
        .onAppear {
            viewModel.updateEvents()
        }
    }

}

#Preview {
    EventsView()
}
