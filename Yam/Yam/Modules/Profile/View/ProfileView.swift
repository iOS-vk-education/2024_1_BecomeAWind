import SwiftUI

struct ProfileView: View {

    @StateObject private var viewModel = ProfileViewModel()

    var body: some View {
        ZStack {
            /// events list
            List {
                Rectangle()
                    .frame(height: ProfileConst.topTabBarHeight)
                    .foregroundColor(Colors.clear)
                    .listRowSeparator(.hidden)

                ForEach(
                    viewModel.activeTab == .myEvents
                     ? viewModel.db.myEvents
                     : viewModel.db.subscriptions,
                     id: \.self
                ) { event in
                    ProfileEventCard(
                        viewModel: viewModel,
                        image: event.image,
                        title: event.title,
                        seats: String(event.seats),
                        link: event.link,
                        date: DateHandler.getDateString(from: event.date)
                    )
                    .listRowSeparator(.hidden)
                }

                Rectangle()
                    .frame(height: EntryConst.tabBarHeight)
                    .foregroundColor(Colors.clear)
                    .listRowSeparator(.hidden)
            }
            .listStyle(.plain)

            /// top tab bar
            ProfileTopTabBar(viewModel: viewModel)
        }
        .edgesIgnoringSafeArea(.top)
    }

}

#Preview {
    ProfileView()
}
