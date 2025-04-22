import SwiftUI

struct EntryTabBar: View {

    @ObservedObject var viewModel: AuthorizedEntryViewModel

    var body: some View {
        VStack {
            Spacer()
            HStack {
                configureTabs()
            }
            .padding()
            .frame(height: AuthorizedEntryConst.tabBarHeight)
            .background(.thinMaterial)
            .cornerRadius(
                Const.cornerRadius,
                corners: [.topLeft, .topRight]
            )
        }
    }

    private func configureTabs() -> some View {
        ForEach(viewModel.tabs) { tab in
            EntryTabItem(
                viewModel: viewModel,
                thisTab: tab.tab,
                imageSystemName: tab.imageName,
                title: tab.title
            )
            .onTapGesture {
                withAnimation(Const.tabBarItemSwapAnimation) {
                    viewModel.changeActive(to: tab.tab)
                }
            }
        }
    }

}

private struct EntryTabItem: View {

    @ObservedObject var viewModel: AuthorizedEntryViewModel
    let thisTab: AuthorizedEntryTab

    let imageSystemName: String
    let title: String

    var body: some View {
        VStack {
            Image(systemName: imageSystemName)
                .resizable()
                .frame(
                    width: AuthorizedEntryConst.tabBarImageSize,
                    height: AuthorizedEntryConst.tabBarImageSize
                )
                .foregroundColor(
                    viewModel.activeTab == thisTab
                    ? .purple
                    : .white
                )
            YText(
                title,
                font: AuthorizedEntryConst.tabBarItemTitleFont,
                foregroundColor: viewModel.activeTab == thisTab
                ? .purple
                : .white
            )
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }

}
