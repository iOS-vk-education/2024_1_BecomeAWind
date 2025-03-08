import SwiftUI

enum Tab {
    case profile
    case search
    case map
}

struct YamTabBar: View {
    @Binding var activeTab: Tab

    var body: some View {
        HStack {
            TabItem(
                activeTab: $activeTab,
                thisTab: .profile,
                imageSystemName: "person.crop.circle",
                title: "профиль"
            )
            .onTapGesture {
                withAnimation(EntryConst.fastAnimation) {
                    activeTab = .profile
                }
            }

            TabItem(
                activeTab: $activeTab,
                thisTab: .search,
                imageSystemName: "widget.small",
                title: "поиск"
            )
            .onTapGesture {
                withAnimation(EntryConst.fastAnimation) {
                    activeTab = .search
                }
            }

            TabItem(
                activeTab: $activeTab,
                thisTab: .map,
                imageSystemName: "map",
                title: "карта"
            )
            .onTapGesture {
                withAnimation(EntryConst.fastAnimation) {
                    activeTab = .map
                }
            }
        }
        .padding()
        .frame(height: EntryConst.tabBarHeight)
        .background(.thinMaterial)

        .cornerRadius(
            EntryConst.tabBarCornerRadius,
            corners: [.topLeft, .topRight]
        )
    }

}

private struct TabItem: View {

    @Binding var activeTab: Tab
    let thisTab: Tab

    let imageSystemName: String
    let title: String

    var body: some View {
        VStack {
            Image(systemName: imageSystemName)
                .resizable()
                .frame(
                    width: EntryConst.tabBarImageSize,
                    height: EntryConst.tabBarImageSize
                )
                .foregroundColor(
                    activeTab == thisTab
                    ? ColorPack.purple
                    : ColorPack.white
                )
            YamText(
                title,
                font: Fonts.Entry.tabBarItemTitleFont,
                foregroundColor: activeTab == thisTab
                ? ColorPack.purple
                : ColorPack.white
            )
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    @Previewable @State var a: Tab = .search
    YamTabBar(activeTab: $a)
}
