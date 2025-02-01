import SwiftUI

private enum FeedViewSizesPack {
    static let headerTitleFontSize: CGFloat = 30
}

struct FeedView: View {
    @StateObject private var viewModel = FeedViewModel(model: FeedModel())
    @State private var isActiveCreateEventView = false
    @State private var selectedEvent: Event?

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 2)

    var body: some View {
        ZStack {
            ColorPack.black
                .ignoresSafeArea()

            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    Section {
                        ForEach(viewModel.events, id: \.id) { event in
                            Button {
                                selectedEvent = event
                            } label: {
                                VStack {
                                    YamImage(image: event.description.image, size: UIScreen.main.bounds.width / 2 - 15)
                                    YamWhiteText(text: event.description.title,
                                                 fontWeight: .regular)
                                        .lineLimit(1)
                                    YamCapsuleLabel(title: DateConverter.getDateString(from: event.organization.date),
                                                    fontSize: 15)
                                    Spacer()
                                }
                                .frame(maxHeight: UIScreen.main.bounds.height / 2)
                            }
                        }
                    } header: {
                        YamWhiteText(text: "лента мероприятий",
                                     fontSize: FeedViewSizesPack.headerTitleFontSize)
                            .padding()
                    }
                }
                .padding(10)
                .background(ColorPack.black)
            }
        }
        .sheet(item: $selectedEvent) { event in
            DetailedInfoView(events: [event])
        }
    }
}

#Preview {
    FeedView()
}
