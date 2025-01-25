import SwiftUI

struct FeedView: View {
    @State private var isActiveCreateEventView = false
    @ObservedObject var temp = TempDatabase.shared

    var body: some View {
        Text("Лента")
//        List(temp.events) { event in
//            Section {
//                VStack(alignment: .leading) {
//                    Text(event.title)
//                    Text(event.description)
//                    Text(event.place)
//                    Text("\(event.seats)")
//                }
//            }
//        }
    }
}

#Preview {
    FeedView()
}
