import SwiftUI

struct MyEventsView: View {

    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: MyEventsViewModel

    var body: some View {
        ZStack {
            List {
                ForEach(viewModel.myEvents, id: \.self) { event in
                    EventCard(
                        viewModel: viewModel,
                        eventType: .my,
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
                    RectImageButton(imageName: "plus", imageScale: 0.55, background: Gradient.pinkIndigo) {
                        viewModel.showCreateEvent()
                    }

                    EventsCountView(countString: viewModel.getMyEventsCount())

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
            }
        }
        .fullScreenCover(isPresented: $viewModel.isActiveBuildEvent) {
            if let event = viewModel.selectedEvent {
                BuildEventView(
                    viewModel: BuildEventViewModel(
                        builtEventType: .edit,
                        event: event
                    ),
                    onBuild: {
                        Task {
                            await viewModel.updateEvent(eventID: event.id)
                        }
                    },
                    onDelete: {
                        viewModel.removeEventFromTable(eventID: event.id)
                    }
                )
            }
        }
        .alert("указана неверная ссылка", isPresented: $viewModel.invalidLink) {
            Button("ок", role: .cancel) { }
        }
    }

}
