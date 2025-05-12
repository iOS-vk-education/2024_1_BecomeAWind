import SwiftUI

struct FeedView: View {

    @StateObject private var viewModel = FeedViewModel()
    @State private var searchText: String = ""
    @State private var searchTimer: Timer?

    var body: some View {
        /// events list
        List {
            HStack {
                TextField("Поиск по названию", text: $searchText)
                    .padding(15)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .onChange(of: searchText) { newValue in
                        searchTimer?.invalidate()
                        
                        searchTimer = Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { _ in
                            viewModel.filterEvents(by: newValue)
                        }
                    }
                
                Button(action: {
                    viewModel.filterEvents(by: searchText)
                }) {
                    Image(systemName: "magnifyingglass")
                        .padding()
                }
                .background(Color.blue)
                .clipShape(Circle())
                .foregroundColor(.white)
            }
            
            ForEach(viewModel.filteredEvents, id: \.self) { event in
                
                EventCard(
                    viewModel: viewModel,
                    cardType: .external,
                    event: event
                )
                .listRowSeparator(.hidden)
            }

            Rectangle()
                .frame(height: EntryConst.tabBarHeight)
                .foregroundColor(.clear)
                .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .onAppear { viewModel.updateFeed() }
    }

}

#Preview {
    FeedView()
}
