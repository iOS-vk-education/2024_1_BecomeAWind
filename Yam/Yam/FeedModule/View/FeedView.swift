import SwiftUI

struct FeedView: View {
    @StateObject private var viewModel = FeedViewModel(model: FeedModel())
    @State private var isActiveCreateEventView = false
    

    var body: some View {
        List {
            Section {
                HStack {
                    Spacer()
                    CreateEventText(text: "Лента мероприятий",
                                    fontSize: CreateEventViewSizesPack.newEventLabelFontSize)
                    Spacer()
                }
            }
            .listRowBackground(ColorsPack.black)

            Section {
                ForEach(viewModel.events, id: \.id) { event in
                    Text(event.description.title)
                }
            }
            .listRowBackground(ColorsPack.gray)


        }
        .background(ColorsPack.black)
    }
}

#Preview {
    FeedView()
}
