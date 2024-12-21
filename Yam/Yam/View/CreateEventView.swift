import SwiftUI

struct CreateEventView: View {
    @State private var eventTitle = ""

    var body: some View {
        VStack {
            TextField("Event title", text: $eventTitle)
                .padding()
                .foregroundColor(Colors.white)
                .background(Colors.black)
            Button {
                print("write")
            } label: {
                IndigoPurpleButtonLabel(title: "CREATE EVENT")
            }

        }
        .padding(Sizes.sidePadding)


    }
}

#Preview {
    CreateEventView()
}
