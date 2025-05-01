import SwiftUI

struct Loader: View {

    var body: some View {
        HStack {
            Spacer()
            ProgressView()
            Spacer()
        }
    }

}

#Preview {
    Loader()
}
