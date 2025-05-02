import SwiftUI

struct FeedView: View {

    @ObservedObject var viewModel: FeedViewModel

    var body: some View {
        /// events list
        List {
            ForEach(viewModel.feedEvents.filter { !viewModel.dbService.myEventsIDs.contains($0.id) }, id: \.self) { event in
                EventCard(
                    viewModel: viewModel,
                    event: event,
                    eventType: viewModel.dbService.subscriptionsIDs.contains(event.id)
                    ? .added
                    : .notAdded
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
            Button("ок", role: .cancel) {}
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

#Preview {
    FeedView(viewModel: FeedViewModel())
}
