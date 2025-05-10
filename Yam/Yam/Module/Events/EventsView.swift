import SwiftUI

struct EventsView: View {

    @ObservedObject var viewModel: EventsViewModel

    var body: some View {
        NavBar(viewModel: viewModel) {
            /// events list
            List {
                NavBarSpace()

                ForEach(
                    viewModel.activeTab == .myEvents
                     ? viewModel.myEvents
                     : viewModel.subscriptions,
                     id: \.self
                ) { event in
                    EventCard(
                        viewModel: viewModel,
                        eventType: viewModel.getEventType(event: event),
                        event: event
                    )
                    .listRowSeparator(.hidden)
                }

                if viewModel.isLoading {
                    Loader()
                }

                TabBarSpace()
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
        .sheet(isPresented: $viewModel.isActiveEventLocation) {
            if let event = viewModel.selectedEvent {
                EventLocationView(viewModel: EventLocationViewModel(event: event))
                    .presentationDragIndicator(.visible)
            }
        }
        .sheet(isPresented: $viewModel.isActiveBuildEvent) {
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
        .alert("не удалось подписаться", isPresented: $viewModel.subscribeFail) {
            Button("ок", role: .cancel) {}
        }
        .alert("не удалось отписаться", isPresented: $viewModel.unsubcribeFail) {
            Button("ок", role: .cancel) {}
        }
        .alert("ошибка", isPresented: $viewModel.fail) {
            Button("ок", role: .cancel) {}
        }
    }

}
