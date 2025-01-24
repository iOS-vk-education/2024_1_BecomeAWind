import SwiftUI

struct TabBarView: View {
    @State private var feedViewIsActive = false
    @State private var createEventViewIsActive = false

    var body: some View {
        HStack {
            VStack {
                Image(systemName: "text.page.fill")
                    .foregroundColor(.white)
                    .font(.system(size: BaseSizesPack.tabBarItemSize))
                    .onTapGesture {
                        feedViewIsActive.toggle()
                    }
                    .padding(10)
            }
            .background(.black)
            .cornerRadius(BaseSizesPack.coreCornerRadius)
            .padding(20)
            .sheet(isPresented: $feedViewIsActive) {
                FeedView()
            }

            VStack {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(.white)
                    .font(.system(size: BaseSizesPack.tabBarItemSize))
                    .onTapGesture {
                        createEventViewIsActive.toggle()
                    }
                    .padding(10)
            }
            .background(.black)
            .cornerRadius(BaseSizesPack.coreCornerRadius)
            .padding(20)
            .sheet(isPresented: $createEventViewIsActive) {
                CreateEventView(viewModel: CreateEventViewModel(model: CreateEventModel()), createEventViewIsActive: $createEventViewIsActive)
                }

        }
        .background(GradientsPack.indigoPurple)
        .cornerRadius(BaseSizesPack.coreCornerRadius)
        .padding()
    }
}

private struct TabBarItem: View {
    let imageName: String
    var body: some View {
        Image(systemName: imageName)
            .resizable()
    }
}

#Preview {
    TabBarView()
}
