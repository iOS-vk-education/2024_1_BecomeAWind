import SwiftUI

struct NavBar<ViewModel: NavBarViewModelProtocol, Content: View>: View {

    @ObservedObject var viewModel: ViewModel
    let viewUnderNavBar: Content

    init(viewModel: ViewModel, @ViewBuilder viewUnderNavBar: () -> Content) {
        self.viewModel = viewModel
        self.viewUnderNavBar = viewUnderNavBar()
    }

    var body: some View {
        ZStack {
            VStack {
                viewUnderNavBar
            }

            NavBarStack {
                NavBarTabItem(viewModel: viewModel, thisTab: viewModel.leftTab)
                    .onTapGesture {
                        withAnimation(Const.tabBarItemSwapAnimation) {
                            viewModel.changeActiveTabTo(viewModel.leftTab)
                        }
                    }

                VStack {
                    Spacer()
                    YCircleButton(imageName: "plus") {
                        viewModel.centerButtonAction()
                    }
                }
                .opacity(viewModel.isVisibleCenterButton ? 1 : 0)

                NavBarTabItem(viewModel: viewModel, thisTab: viewModel.rightTab)
                    .onTapGesture {
                        withAnimation(Const.tabBarItemSwapAnimation) {
                            viewModel.changeActiveTabTo(viewModel.rightTab)
                        }
                    }
            }
        }
        .edgesIgnoringSafeArea(.top)
    }

}
