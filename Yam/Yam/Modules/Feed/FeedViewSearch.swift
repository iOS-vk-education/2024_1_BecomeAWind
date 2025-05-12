import SwiftUI

struct FeedViewSearch: View {
    @ObservedObject var viewModel: FeedViewModel
    @State private var searchText: String = ""
    
    var body: some View {
        
        VStack {
            HStack {
                TextField("Поиск по названию", text: $searchText)
                    .padding(10)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .onChange(of: searchText) { newValue in
                        viewModel.filterEvents(by: newValue)
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
            
            List(viewModel.filteredEvents) { event in
                Text(event.title)
            }
        }
    }
}
