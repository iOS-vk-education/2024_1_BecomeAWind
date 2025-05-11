import SwiftUI

struct InfoView: View {

    private let authInteractor = AuthInteractor.shared

    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: InfoViewModel

    var body: some View {
        VStack {
            YText("инфо", font: Const.headerTextFont)
                .padding(.top)

            Text(viewModel.userEmail)
                .fixedSizeText(background: .thinMaterial)
                .onAppear {
                    viewModel.getUserEmail()
                }

            Text(viewModel.getSearchRadius())
                .fixedSizeText(background: .thinMaterial)

            Spacer()

            HStack {
                RectImageButton(imageName: "iphone.and.arrow.right.outward",
                                imageScale: 0.5,
                                background: Gradient.blackPink) {
                    viewModel.signOut()
                }

                DismissButton {
                    dismiss()
                }
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
    InfoView(viewModel: InfoViewModel(navManager: NavigationManager()))
}
