import SwiftUI

struct EventsAccordionView: View {

    @ObservedObject var viewModel: EventsAccordionViewModel
    @State private var currentIndex = 0
    @State private var dragOffset: CGFloat = 0

    var body: some View {
        ZStack {
            ForEach(Array(viewModel.eventPack.enumerated().sorted {
                abs($0.offset - currentIndex) > abs($1.offset - currentIndex)
            }), id: \.element.id) { index, event in
                EventCard(viewModel: viewModel, eventType: viewModel.getEventType(event), event: event)
                    .offset(x: CGFloat(index - currentIndex) * Const.screenWidth + dragOffset)
                    .scaleEffect(index == currentIndex ? 1 : 0.85)
                    .animation(.spring(response: 0.3, dampingFraction: 0.8), value: dragOffset)
                    .animation(.spring(response: 0.3, dampingFraction: 0.8), value: currentIndex)

                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                dragOffset = value.translation.width
                            }

                            .onEnded { value in
                                if value.translation.width > 70 {
                                    currentIndex = max(currentIndex - 1, 0)
                                } else if value.translation.width < -70 {
                                    currentIndex = min(currentIndex + 1, viewModel.eventPack.count - 1)
                                }
                                dragOffset = 0
                            }
                    )
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
    EventsAccordionView(viewModel:
                            EventsAccordionViewModel(eventPack:
                                                        [Const.defaultEvent, Const.defaultEvent2, Const.defaultEvent3]
                                                    )
    )
}
