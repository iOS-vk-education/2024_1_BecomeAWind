import SwiftUI

private enum FeedViewSizesPack {
    static let headerTitleFontSize: CGFloat = 30
}

struct FeedView: View {
    @StateObject private var viewModel = FeedViewModel(model: FeedModel())
    @State private var isActiveCreateEventView = false
    @State private var selectedEvent: Event? = nil

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 2)

    var body: some View {
        ZStack {
            ColorsPack.black
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
                                    YamText(text: event.description.title)
                                        .lineLimit(2)
                                    YamCapsuleLabel(title: "20.10.25 | 14:00",
                                                    background: GradientsPack.indigoPurple
                                    )
                                    Spacer()
                                }
                            }
                        }
                    } header: {
                        YamText(text: "Лента мероприятий", fontSize: FeedViewSizesPack.headerTitleFontSize)
                            .padding()
                    }
                }
                .padding(10)
                .background(ColorsPack.black)
            }
        }
        .sheet(item: $selectedEvent) { event in
            DetailedInfoView(event: event)
        }
    }
}

#Preview {
    FeedView()
}
