import SwiftUI

struct ProfileView: View {

    @StateObject private var viewModel = ProfileViewModel()

    var body: some View {
        ZStack {
            /// events list
            List {
                Rectangle()
                    .frame(height: ProfileConst.topTabBarHeight)
                    .foregroundColor(.clear)
                    .listRowSeparator(.hidden)

                ForEach(
                    viewModel.activeTab == .myEvents
                     ? viewModel.db.myEvents
                     : viewModel.db.subscriptions,
                     id: \.self
                ) { event in
                    EventCard(
                        viewModel: viewModel,
                        cardType: viewModel.activeTab == .myEvents
                        ? .myEvent
                        : .externalEvent,
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

            /// top tab bar
            ProfileTopTabBar(viewModel: viewModel)
        }
        .edgesIgnoringSafeArea(.top)
        .fullScreenCover(
            isPresented: $viewModel.isActiveEventLocation
        ) {
            if let event = viewModel.selectedEvent {
                EventLocationView(viewModel: EventLocationViewModel(event: event))
            }
        }
        .sheet(isPresented: $viewModel.isActiveEditEvent) {
            if let event = viewModel.selectedEvent {
                MakeEventView(
                    viewModel: MakeEventViewModel(
                        typeOfMakeEventView: .editEvent,
                        event: event
                    )
                )
            }
        }
        .alert(
            "указана неверная ссылка",
            isPresented: $viewModel.invalidLink
        ) {
            Button("ок", role: .cancel) { }
        }
    }

}

#Preview {
    ProfileView()
}
