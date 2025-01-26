import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            Spacer()
            YamText(text: "Мероприятие", fontSize: 30)
            Spacer()
        }
        .padding()
    }
}
