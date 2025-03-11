import Combine

final class EditEventViewModel: ObservableObject {

    @Published var event: Event

    init(event: Event) {
        self.event = event
    }

}


