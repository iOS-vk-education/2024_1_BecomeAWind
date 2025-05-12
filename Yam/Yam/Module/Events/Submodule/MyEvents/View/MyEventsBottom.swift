import SwiftUI

struct MyEventsBottom: View {

    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: MyEventsViewModel

    var body: some View {
        VStack {
            Spacer()

            HStack {
                RectImageButton(imageName: "plus", imageScale: 0.55, background: Gradient.pinkIndigo) {
                    viewModel.showCreateEvent()
                }

                EventsCountView(countString: viewModel.getMyEventsCount())

                DismissButton {
                    dismiss()
                }
            }
            TabBarSpace()
        }
    }

}

#Preview {
    MyEventsBottom(viewModel: MyEventsViewModel())
}
