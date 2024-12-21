import SwiftUI

struct ProfileView: View {
    @State private var createEventViewIsActive = false

    var body: some View {
        VStack {
            Button {
                createEventViewIsActive.toggle()
            } label: {
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: Sizes.createEventButtonSize, height: Sizes.createEventButtonSize)
                    .padding()
                    .background(Gradients.indigoPurple)
                    .cornerRadius(Sizes.coreCornerRadius)
            }
            .tint(Colors.black)
            Spacer()
        }
        .sheet(isPresented: $createEventViewIsActive) {
            CreateEventView()
        }
    }
}

#Preview {
    ProfileView()
}
