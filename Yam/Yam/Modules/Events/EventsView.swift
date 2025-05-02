import SwiftUI

struct EventsView: View {

    @ObservedObject var viewModel: EventsViewModel

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
                        event: event,
                        eventType: viewModel.getEventType(event: event)
                    )
                    .listRowSeparator(.hidden)
                }

                if viewModel.isLoading {
                    Loader()
                }

                Rectangle()
                    .frame(height: AuthorizedEntryConst.tabBarHeight)
                    .foregroundColor(.clear)
                    .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
        }
        .refreshable {
            Task {
                await viewModel.refresh()
            }
        }
        .fullScreenCover(isPresented: $viewModel.isActiveCreateEvent) {
            BuildEventView()
                .onDisappear {
                    Task {
                        await viewModel.refresh()
                    }
                }
        }
        .fullScreenCover(isPresented: $viewModel.isActiveEventLocation) {
            if let event = viewModel.selectedEvent {
                EventLocationView(viewModel: EventLocationViewModel(event: event))
            }
        }
        .sheet(isPresented: $viewModel.isActiveAction) {
            if let event = viewModel.selectedEvent {
                BuildEventView(
                    viewModel: BuildEventViewModel(
                        builtEventType: .edit,
                        event: event
                    )
                )
                .onDisappear {
                    Task {
                        await viewModel.updateEvent(eventID: event.id)
                    }
                }
            }
        }
        .alert("указана неверная ссылка", isPresented: $viewModel.invalidLink) {
            Button("ок", role: .cancel) { }
        }
        .alert("не удалось подписаться", isPresented: $viewModel.failedToSubcribeAlert) {
            Button("ок", role: .cancel) {}
        }
        .alert("не удалось отписаться", isPresented: $viewModel.failedToUnsubcribeAlert) {
            Button("ок", role: .cancel) {}
        }
        .alert("ошибка", isPresented: $viewModel.fail) {
            Button("ок", role: .cancel) {}
        }
    }

}
