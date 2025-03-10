import SwiftUI

struct EntryTabBar: View {

    @ObservedObject var viewModel: EntryViewModel

    var body: some View {
        VStack {
            Spacer()
            HStack {
                EntryTabItem(
                    viewModel: viewModel,
                    thisTab: .profile,
                    imageSystemName: "person.crop.circle",
                    title: "профиль"
                )
                .onTapGesture {
                    withAnimation(Const.tabBarItemSwapAnimation) {
                        viewModel.changeActiveTabTo(.profile)
                    }
                }

                EntryTabItem(
                    viewModel: viewModel,
                    thisTab: .search,
                    imageSystemName: "widget.small",
                    title: "поиск"
                )
                .onTapGesture {
                    withAnimation(Const.tabBarItemSwapAnimation) {
                        viewModel.changeActiveTabTo(.search)
                    }
                }

                EntryTabItem(
                    viewModel: viewModel,
                    thisTab: .map,
                    imageSystemName: "map",
                    title: "карта"
                )
                .onTapGesture {
                    withAnimation(Const.tabBarItemSwapAnimation) {
                        viewModel.changeActiveTabTo(.map)
                    }
                }
            }
            .padding()
            .frame(height: EntryConst.tabBarHeight)
            .background(.thinMaterial)
            .cornerRadius(
                Const.cornerRadius,
                corners: [.topLeft, .topRight]
            )
        }
    }

}

private struct EntryTabItem: View {

    @ObservedObject var viewModel: EntryViewModel
    let thisTab: EntryTab

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
                    ? Colors.purple
                    : Colors.white
                )
            YText(
                title,
                font: EntryConst.tabBarItemTitleFont,
                foregroundColor: viewModel.activeTab == thisTab
                ? Colors.purple
                : Colors.white
            )
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }

}

#Preview {
    @Previewable @StateObject var vm = EntryViewModel()
    EntryTabBar(viewModel: vm)
}
