import Foundation
import Combine
import SwiftUI

final class FeedViewModel: ObservableObject {
    @ObservedObject private var model: FeedModel
    @Published var events: [Event] = []
    private var cancellables = Set<AnyCancellable>()

    init(model: FeedModel) {
        self.model = model

        self.model.$tempDatabase
            .sink { [weak self] _ in
                self?.updateEvents()
            }
            .store(in: &cancellables)
    }

    func updateEvents() {
        events = model.events
    }

}
