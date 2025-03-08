import SwiftUI

struct YamTabBar: View {

    @ObservedObject var viewModel: EntryViewModel

    var body: some View {
        HStack {
            TabItem(
                viewModel: viewModel,
                thisTab: .profile,
                imageSystemName: "person.crop.circle",
                title: "профиль"
            )
            .onTapGesture {
                withAnimation(EntryConst.fastAnimation) {
                    viewModel.changeActiveTabTo(.profile)
                }
            }

            TabItem(
                viewModel: viewModel,
                thisTab: .search,
                imageSystemName: "widget.small",
                title: "поиск"
            )
            .onTapGesture {
                withAnimation(EntryConst.fastAnimation) {
                    viewModel.changeActiveTabTo(.search)
                }
            }

            TabItem(
                viewModel: viewModel,
                thisTab: .map,
                imageSystemName: "map",
                title: "карта"
            )
            .onTapGesture {
                withAnimation(EntryConst.fastAnimation) {
                    viewModel.changeActiveTabTo(.map)
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

    @ObservedObject var viewModel: EntryViewModel
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
                    viewModel.activeTab == thisTab
                    ? ColorPack.purple
                    : ColorPack.white
                )
            YamText(
                title,
                font: Fonts.Entry.tabBarItemTitleFont,
                foregroundColor: viewModel.activeTab == thisTab
                ? ColorPack.purple
                : ColorPack.white
            )
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }

}

#Preview {
    @Previewable @StateObject var vm = EntryViewModel()
    YamTabBar(viewModel: vm)
}
