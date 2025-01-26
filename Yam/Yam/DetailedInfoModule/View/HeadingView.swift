import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            Spacer()
            Text("Мероприятие")
                .frame(alignment: .center)
                .font(.largeTitle)
                .colorInvert()
            Spacer()
        }
        .padding()
    }
}
