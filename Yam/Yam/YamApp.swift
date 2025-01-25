import SwiftUI

@main
struct YamApp: App {
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            LoginScreenIntegrator()
                .edgesIgnoringSafeArea(.all)

//            MainView()
        }
    }
}
