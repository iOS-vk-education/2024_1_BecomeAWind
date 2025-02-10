import SwiftUI

struct TabBarView: View {
    @State private var isActiveFeedView = false
    @State private var isActiveCreateEventView = false

    var body: some View {
        VStack {
            Spacer()
            HStack {
                // FeedView
                TabBarItem(imageSystemName: "text.page.fill")
                    .onTapGesture {
                        isActiveFeedView.toggle()
                    }
                    .fullScreenCover(isPresented: $isActiveFeedView) {
                        FeedView(isActiveFeedView: $isActiveFeedView)
                    }

                // CreateEventView
                TabBarItem(imageSystemName: "plus.circle.fill")
                    .onTapGesture {
                        isActiveCreateEventView.toggle()
                    }
                    .sheet(isPresented: $isActiveCreateEventView) {
                        CreateEventView(isActiveCreateEventView: $isActiveCreateEventView)
                    }
            }
            .background(GradientPack.purpleIndigo)
            .cornerRadius(SizePack.coreCornerRadius)
            .padding(.bottom, 5)
        }

    }
}

struct TabBarItem: View {
    let imageSystemName: String

    var body: some View {
        VStack {
            Image(systemName: imageSystemName)
                .foregroundColor(.white)
                .font(.system(size: SizePack.tabBarItemSize))
                .padding(10)
        }
        .background(.black)
        .cornerRadius(SizePack.coreCornerRadius)
        .padding(10)
    }
}

#Preview {
    TabBarView()
}
