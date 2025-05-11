import Foundation
import SwiftUI

final class EventsViewModel: ObservableObject {

    private(set) var tabs: [EventsTabItemConfig] = []
    @Published var activeTab: EventsTab = .myEvents

    init() {
        tabs = [
            EventsTabItemConfig(tab: .myEvents, title: "мои ивенты", imageName: "photo.stack"),
            EventsTabItemConfig(tab: .feed, title: "лента", imageName: "person.2.crop.square.stack"),
            EventsTabItemConfig(tab: .subscriptions, title: "подписки", imageName: "rectangle.stack.badge.plus")
        ]
    }

    func changeActive(to tab: EventsTab) {
        activeTab = tab
    }

}

// MARK: - Configure views

extension EventsViewModel {

    func makeMyEventsView() -> MyEventsView {
        let vm = MyEventsViewModel()
        let view = MyEventsView(viewModel: vm)
        return view
    }

    func makeFeedView() -> FeedView {
        let vm = FeedViewModel()
        let view = FeedView(viewModel: vm)
        return view
    }

    func makeSubscriptionsView() -> SubscriptionsView {
        let vm = SubscriptionsViewModel()
        let view = SubscriptionsView(viewModel: vm)
        return view
    }

}
