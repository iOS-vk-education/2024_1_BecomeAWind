import SwiftUI

struct MainView: View {
    @State private var selectedTab: Tab = .map

    var body: some View {
            ZStack {
                // Views
                TabContentView(selectedTab: selectedTab)

                            Spacer()

                            // Таб-бар для переключения табов
                            TabBarView(selectedTab: $selectedTab)
            }
    }
}

struct TabContentView: View {
    var selectedTab: Tab

    var body: some View {
        VStack {
            switch selectedTab {
            case .map:
                MapScreenView()
            case .feed:
                FeedView()
            }
        }
    }
}

#Preview {
    MainView()
}
