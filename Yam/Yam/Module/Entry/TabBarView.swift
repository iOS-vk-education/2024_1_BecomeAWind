import SwiftUI

struct TabBarView: View {
    @State private var feedViewIsActive = false
    @State private var createEventViewIsActive = false

    var body: some View {
        VStack {
            Spacer()
            HStack {
                // FeedView
                TabBarItem(imageSystemName: "text.page.fill")
                    .onTapGesture {
                        feedViewIsActive.toggle()
                    }
                    .sheet(isPresented: $feedViewIsActive) {
                        FeedView()
                    }

                // CreateEventView
                TabBarItem(imageSystemName: "plus.circle.fill")
                    .onTapGesture {
                        createEventViewIsActive.toggle()
                    }
                    .sheet(isPresented: $createEventViewIsActive) {
                        CreateEventView(isActiveCreateEventView: $createEventViewIsActive)
                    }
            }
            .background(GradientPack.purpleIndigo)
            .cornerRadius(SizePack.coreCornerRadius)
            .padding()
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
        .padding(20)
    }
}

#Preview {
    TabBarView()
}
