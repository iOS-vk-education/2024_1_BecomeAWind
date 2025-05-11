import SwiftUI

struct SubscriptionsView: View {

    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: SubscriptionsViewModel

    var body: some View {
        ZStack {
            List {
                ForEach(viewModel.subscriptions, id: \.self) { event in
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

                EventsBottomSpace()
            }
            .listStyle(.plain)


            VStack {
                Spacer()


                HStack {
                    EventsCountView(countString: viewModel.getSubscriptionsCount())

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
