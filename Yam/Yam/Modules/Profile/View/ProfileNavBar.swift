import SwiftUI

struct ProfileNavBar: View {

    @ObservedObject var viewModel: ProfileViewModel

    var body: some View {
        VStack {
            HStack {
                ProfileTabItem(
                    viewModel: viewModel,
                    thisTab: .myEvents
                )
                .onTapGesture {
                    withAnimation(Const.tabBarItemSwapAnimation) {
                        viewModel.changeActiveTabTo(.myEvents)
                    }
                }

                /// open create event button
                VStack {
                    Spacer()
                    YCircleButton(imageName: "plus") {
                        viewModel.toggleCreateEvent()
                    }
                }

                ProfileTabItem(
                    viewModel: viewModel,
                    thisTab: .subscriptions
                )
                .onTapGesture {
                    withAnimation(Const.tabBarItemSwapAnimation) {
                        viewModel.changeActiveTabTo(.subscriptions)
                    }
                }
            }
            .padding()
            .frame(height: ProfileConst.navBarHeight)
            .background(.thinMaterial)
            .cornerRadius(
                Const.cornerRadius,
                corners: [.bottomLeft, .bottomRight]
            )
            Spacer()
        }
        .fullScreenCover(
            isPresented: $viewModel.isActiveCreateEvent
        ) {
            MakeEventView(
                viewModel: MakeEventViewModel()
            )
            .onDisappear {
                viewModel.updateEvents()
            }
        }
    }

}

private struct ProfileTabItem: View {

    @ObservedObject var viewModel: ProfileViewModel
    let thisTab: ProfileTab

    var body: some View {
        VStack {
            Spacer()
            YText(
                thisTab.rawValue,
                font: ProfileConst.topTabBarItemTitleFont,
                foregroundColor: thisTab == viewModel.activeTab
                ? .purple
                : .white
            )
        }
        .frame(maxWidth: .infinity)
    }

}

#Preview {
    ProfileNavBar(viewModel: ProfileViewModel())
}
