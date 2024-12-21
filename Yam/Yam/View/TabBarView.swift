import SwiftUI

enum Tab: String, CaseIterable {
    case map = "map.fill"
    case feed = "text.page.fill"
}

struct TabBarView: View {
    @Binding var selectedTab: Tab

    var body: some View {
        HStack {
            ForEach(Tab.allCases, id: \.rawValue) { tab in
                VStack {
                    Image(systemName: tab.rawValue)
                        .foregroundColor(.white)
                        .font(.system(size: Sizes.tabBarItemSize))
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.1)) {
                                selectedTab = tab
                            }
                        }
                        .padding(10)
                }
                .background(.black)
                .cornerRadius(Sizes.coreCornerRadius)
                .scaleEffect(tab == selectedTab ? 1.25 : 1.0)
            }
            .padding(20)
        }
        .background(Gradients.indigoPurple)
        .cornerRadius(Sizes.coreCornerRadius)
        .padding()
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
    TabBarView(selectedTab: .constant(.map))
}
