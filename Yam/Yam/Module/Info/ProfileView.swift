import SwiftUI

struct InfoView: View {

    private let authInteractor = AuthInteractor.shared
    @ObservedObject var viewModel: ProfileViewModel

    var body: some View {
        VStack {
            YText("профиль", font: Const.headerTextFont)
                .padding(.top)

            Text(viewModel.userEmail)
                .fixedSizeText(background: .thinMaterial)
                .onAppear {
                    viewModel.getUserEmail()
                }

            Text(viewModel.getSearchRadius())
                .fixedSizeText(background: .thinMaterial)

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
    InfoView(viewModel: ProfileViewModel(navManager: NavigationManager()))
}
