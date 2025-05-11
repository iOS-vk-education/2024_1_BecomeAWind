import SwiftUI

struct FeedView: View {

    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: FeedViewModel

    var body: some View {
        ZStack {
            List {
                ForEach(viewModel.feedEvents.filter { !viewModel.dbService.myEventsIDs.contains($0.id) }, id: \.self) { event in
                    EventCard(
                        viewModel: viewModel,
                        eventType: viewModel.dbService.subscriptionsIDs.contains(event.id)
                        ? .added
                        : .notAdded,
                        event: event
                    )
                    .listRowSeparator(.hidden)
                }

                if viewModel.isLoading {
                    Loader()
                }

                EventsBottomSpace()
            }
            .listStyle(.plain)

            VStack {
                Spacer()

                HStack {
                    EventsCountView(countString: viewModel.getFeedEventsCount())

                    DismissButton {
                        dismiss()
                    }
                }

                TabBarSpace()
            }
        }
        .refreshable {
            Task {
                await viewModel.refresh()
            }
        }
        .sheet(isPresented: $viewModel.isActiveEventLocation) {
            if let event = viewModel.selectedEvent {
                EventLocationView(viewModel: EventLocationViewModel(event: event))
            }
        }
        .alert("указана неверная ссылка", isPresented: $viewModel.invalidLink) {
            Button("ок", role: .cancel) {}
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

#Preview {
    FeedView(viewModel: FeedViewModel())
}
