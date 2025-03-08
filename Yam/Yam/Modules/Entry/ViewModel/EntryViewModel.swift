import SwiftUI

final class EntryViewModel: ObservableObject {
    @Published var activeTab: Tab = .profile

    func changeActiveTabTo(_ tab: Tab) {
        activeTab = tab
    }
}

