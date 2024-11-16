import SwiftUI

enum Tab: String, CaseIterable {
    case map = "map"
    case feed = "text.page"

    var makeView: any View {
        switch self {
        case .map:
            return MapView()
        case .feed:
            return FeedView()
        }
    }
}

struct TabBar: View {
    @Binding var selectedTab: Tab
    var itemSize: CGFloat = 50

    var body: some View {
        VStack {
            HStack {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    VStack {
                        Image(systemName: tab.rawValue)
                            .foregroundColor(.white)
                            .font(.system(size: 25))
                            .onTapGesture {
                                withAnimation(.easeIn(duration: 0.1)) {
                                    selectedTab = tab
                                }
                            }
                            .padding(10)
                    }
                    .background(.black)
                    .cornerRadius(10)
                    .scaleEffect(tab == selectedTab ? 1.25 : 1.0)
                }
                .padding(20)
            }
        }
    }
}

private struct TabBarItem: View {
    let imageName: String
    var body: some View {
        Image(systemName: imageName)
            .resizable()
    }
}

#Preview {
    TabBar(selectedTab: .constant(.map))
}

