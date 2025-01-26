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

extension FeedViewModel {
    func getDateString(from date: DateModel) -> String {
        var result = ""
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy\nHH:mm\n"

        result = formatter.string(from: date.date)
        result += date.timeZome.localizedName(for: .standard, locale: Locales.ru) ?? ""

        return result
    }
}
