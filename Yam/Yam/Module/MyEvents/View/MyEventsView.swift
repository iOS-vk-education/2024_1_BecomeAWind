import SwiftUI

enum MyEventsSegment {
    case yours
    case subscriptions
}

struct MyEventsView: View {
    @State private var segment = MyEventsSegment.yours

    var body: some View {
        VStack {
            YamText("список ивентов",
                         fontSize: SizePack.headerTextFontSize)
            Picker("", selection: $segment) {
                Text("твои").tag(MyEventsSegment.yours)
                Text("подписки").tag(MyEventsSegment.subscriptions)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)

            List {
                
            }
        }

    }
}

#Preview {
    MyEventsView()
}
