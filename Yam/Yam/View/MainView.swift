import SwiftUI

struct MainView: View {
    @State private var selectedTab: Tab = .map

    var body: some View {
        ZStack {
            // Views
            VStack {
                switch selectedTab {
                case .map:
                    MapScreenView()
                case .feed:
                    FeedView()
                }
            }

            // Tab bar
            VStack {
                Spacer()
                TabBarView(selectedTab: $selectedTab)
            }
        }
    }
}

#Preview {
    MainView()
}
