import SwiftUI

private enum FeedViewSizesPack {
    static let headerTitleFontSize: CGFloat = 30
}

struct FeedView: View {
    @StateObject private var viewModel = FeedViewModel(model: FeedModel())
    @State private var selectedEvent: Event?

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 2)

    var body: some View {
        /*
        ZStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    Section {
                        ForEach(viewModel.events, id: \.id) { event in
                            Button {
                                selectedEvent = event
                            } label: {
                                VStack {
                                    YamImage(image: event.description.image, size: UIScreen.main.bounds.width / 2 - 15)
//                                    YamText(event.description.title,
//                                                 fontWeight: .regular)
//                                        .lineLimit(1)
//                                    YamCapsuleLabel(title: DateConverter.getDateString(from: event.organization.date),
//                                                    fontSize: 15)
                                    Spacer()
                                }
                                .frame(maxHeight: UIScreen.main.bounds.height / 2)
                            }
                        }
                    } header: {
//                        YamText("лента мероприятий",
//                                fontSize: FeedViewSizesPack.headerTitleFontSize)
//                            .padding()
                    }
                }
                .padding([.horizontal, .top], 10)
                .background(Colors.black)

                Rectangle()
                    .frame(height: EntryConst.tabBarHeight)
                    .foregroundColor(Colors.clear)
            }
        }
        .sheet(item: $selectedEvent) { event in
            DetailedInfoView(events: [event])
        }
*/
        Text("feed")

    }
}

#Preview {
    FeedView()
}
