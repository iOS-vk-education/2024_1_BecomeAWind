import SwiftUI

struct FeedView: View {

    @ObservedObject var viewModel: FeedViewModel

    var body: some View {
        /// events list
        List {
            ForEach(viewModel.events, id: \.self) { event in
                EventCard(
                    viewModel: viewModel,
                    eventType: .notAdded,
                    event: event
                )
                .listRowSeparator(.hidden)
                .onAppear {
                    if viewModel.events.last?.id == event.id {
                        Task {
                            await viewModel.loadNextPackItemsIfNeeded(currentItem: event)
                        }
                    }
                }
            }

            if viewModel.isLoadingMore {
                Loader()
            }

            Rectangle()
                .frame(height: AuthorizedEntryConst.tabBarHeight)
                .foregroundColor(.clear)
                .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .refreshable {
            Task {
                await viewModel.refresh()
            }
        }
        .fullScreenCover(isPresented: $viewModel.isActiveEventLocation) {
            if let event = viewModel.selectedEvent {
                EventLocationView(viewModel: EventLocationViewModel(event: event))
            }
        }
        .alert("указана неверная ссылка", isPresented: $viewModel.invalidLink) {
            Button("ок", role: .cancel) { }
        }
    }

}

#Preview {
    FeedView(viewModel: FeedViewModel())
}
