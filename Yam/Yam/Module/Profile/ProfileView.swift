import SwiftUI

struct ProfileView: View {

    @ObservedObject var viewModel: ProfileViewModel

    var body: some View {
        VStack {
            Rectangle()
                .frame(height: Const.navBarHeight)
                .foregroundColor(.clear)
            Spacer()
            CapsuleButton(title: "выйти", background: Gradient.blackPink) {
                viewModel.signOut()
            }
            Rectangle()
                .frame(height: AuthorizedEntryConst.tabBarHeight)
                .foregroundColor(.clear)
        }
        .alert(
            "не удалось выйти",
            isPresented: $viewModel.isActiveSignOutFailAlert) {
                Button("ок", role: .cancel) {}
        }
    }

}
