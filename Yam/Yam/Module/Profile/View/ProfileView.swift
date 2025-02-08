import SwiftUI

struct ProfileView: View {
    var body: some View {
        List {
            ForEach(0...100, id: \.self) { _ in
                Text("text")
            }

        }
    }
}

#Preview {
    ProfileView()
}
