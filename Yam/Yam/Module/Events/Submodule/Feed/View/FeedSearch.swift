import SwiftUI

struct FeedSearch: View {

    @ObservedObject var viewModel: FeedViewModel

    var body: some View {
        Text("1")
    }

}

#Preview {
    FeedSearch(viewModel: FeedViewModel())
}
