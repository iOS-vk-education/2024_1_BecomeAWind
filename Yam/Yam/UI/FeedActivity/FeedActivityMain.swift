import SwiftUI

struct FeedActivityMain: View {
    let color = UIColor(named: "MainColor")
    var body: some View {
        ZStack {
            Color("MainColor")
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    FeedMainButton()
                    FeedCardFirst()
                    FeedCardSecond()
                    FeedCardThird()
                    FeedCardFirst()
                    FeedCardSecond()
                    FeedCardThird()
                    FeedCardFirst()
                    FeedCardSecond()
                    FeedCardThird()
                    Spacer()
                }
                Spacer()
                    .frame(height: TabBarView.itemSize * 2)
            }
        }
    }
}

struct FeedActivityMain_Previews: PreviewProvider {
    static var previews: some View {
        FeedActivityMain()
    }
}
