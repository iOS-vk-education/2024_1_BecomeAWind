import SwiftUI

struct MainView: View {
    @State private var selectedTab: Tab = .map

    init() {
        UITabBar.appearance().isHidden = true
    }

    var body: some View {
        ZStack {
            VStack {
                switch selectedTab {
                case .map:
                    MapView()
                case .feed:
                    FeedView()
                }
            }

            VStack {
                Spacer()
                TabBar(selectedTab: $selectedTab)
            }

        }
    }
}

#Preview {
    MainView()
}
