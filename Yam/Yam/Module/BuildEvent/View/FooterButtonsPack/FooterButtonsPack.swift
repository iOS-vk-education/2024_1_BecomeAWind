import SwiftUI

struct FooterButtonsPack: View {

    @ObservedObject var viewModel: BuildEventViewModel
    let action: () -> Void

    var body: some View {
        VStack {
            BuildEventButton(viewModel: viewModel) {
                action()
            }

            if viewModel.buildEventType == .edit {
                DeleteEventButton(viewModel: viewModel)
            }

        }
        .padding(.horizontal)
    }
    
}
