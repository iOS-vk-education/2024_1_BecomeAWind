import SwiftUI

enum MyEventsSegment {
    case yours
    case subscriptions
}

struct MyEventsView: View {
    @State private var segment = MyEventsSegment.yours

    var body: some View {
        NavigationStack {
            Form {
                Picker("", selection: $segment) {
                    Text("твои").tag(MyEventsSegment.yours)
                    Text("подписки").tag(MyEventsSegment.subscriptions)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
//                Section {
//                    Picker("", selection: $segment) {
//                        Text("твои").tag(MyEventsSegment.yours)
//                        Text("подписки").tag(MyEventsSegment.subscriptions)
//                    }
//                    .pickerStyle(.segmented)
//                    .padding(.horizontal)
//                }
//
//                Section {
//                    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//                }
//
//                Section {
//                    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    YamText("ивенты",
                            fontSize: SizePack.headerTextFontSize)
                }

                ToolbarItem {
                    Button {

                    } label: {
                        HStack {
                            YamText("",
                                    fontWeight: .regular,
                                    fontSize: 17,
                                    foregroundColor: ColorPack.purple)
                            Image(systemName: "plus.circle")
                        }
                    }
                    .foregroundColor(ColorPack.purple)
                }
            }
        }

    }
}

#Preview {
    MyEventsView()
}
