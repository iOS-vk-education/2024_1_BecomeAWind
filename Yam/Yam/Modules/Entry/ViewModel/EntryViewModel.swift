import SwiftUI

final class EntryViewModel: ObservableObject {

    @Published var activeTab: EntryTab = .profile

    func changeActiveTabTo(_ tab: EntryTab) {
        activeTab = tab
    }
    
}

