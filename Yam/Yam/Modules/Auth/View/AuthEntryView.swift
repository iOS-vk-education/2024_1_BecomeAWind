import SwiftUI

struct AuthEntryView: View {

    @StateObject private var viewModel = AuthViewModel()

    var body: some View {
        NavBar(viewModel: viewModel) {
            Text("1")
        }
    }

}

#Preview {
    AuthEntryView()
}
