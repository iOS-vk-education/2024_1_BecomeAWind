import SwiftUI

struct LoginScreenIntegrator: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UINavigationController {
        let loginScreen = LoginViewController()
        let navController = UINavigationController(rootViewController: loginScreen)
        return navController
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}
}
