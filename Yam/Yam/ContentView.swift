import SwiftUI

struct ContentView: View {
    var body: some View {
//        LoginScreenIntegrator()
//            .edgesIgnoringSafeArea(.all)
        TabBarView(selectedTab: .constant(.map))
    }
}

#Preview {
    ContentView()
}
