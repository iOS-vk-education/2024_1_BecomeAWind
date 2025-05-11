import SwiftUI

struct NavBarTabItem<ViewModel: NavBarViewModelProtocol>: View {

    @ObservedObject var viewModel: ViewModel
    let thisTab: ViewModel.Tab

    var body: some View {
        VStack {
            Spacer()
            YText(
                thisTab.rawValue,
                font: Const.navBarItemTitleFont,
                foregroundColor: thisTab == viewModel.activeTab
                ? .purple
                : .white
            )
        }
        .frame(maxWidth: .infinity)
    }

}


