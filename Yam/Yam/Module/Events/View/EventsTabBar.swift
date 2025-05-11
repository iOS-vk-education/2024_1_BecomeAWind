import SwiftUI

struct EventsTabBar: View {

    @ObservedObject var viewModel: EventsViewModel

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
            ModuleTabItem(
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

private struct ModuleTabItem: View {

    @ObservedObject var viewModel: EventsViewModel
    let thisTab: EventsTab

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
