import SwiftUI

struct ProfileView: View {

    @ObservedObject var viewModel: ProfileViewModel

    var body: some View {
        VStack {
            Spacer()
            RectImageButton(imageName: "iphone.and.arrow.right.outward",
                            imageScale: 0.5,
                            background: Gradient.blackPink) {
                viewModel.signOut()
            }
        }
        .frame(maxWidth: .infinity)
        .background(.black)
        .alert(
            "не удалось выйти",
            isPresented: $viewModel.isActiveSignOutFailAlert) {
                Button("ок", role: .cancel) {}
        }
    }

}

#Preview {
    ProfileView(viewModel: ProfileViewModel(navManager: NavigationManager()))
}
