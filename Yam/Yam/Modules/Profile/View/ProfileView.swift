import SwiftUI

struct ProfileView: View {

    @StateObject private var viewModel = ProfileViewModel()

    var body: some View {
        ZStack {
            /// events list
            List {
                Rectangle()
                    .frame(height: ProfileConst.navBarHeight)
                    .foregroundColor(.clear)
                    .listRowSeparator(.hidden)

                ForEach(
                    viewModel.activeTab == .myEvents
                     ? viewModel.myEvents
                     : viewModel.subscriptions,
                     id: \.self
                ) { event in
                    EventCard(
                        viewModel: viewModel,
                        cardType: viewModel.activeTab == .myEvents
                        ? .my
                        : .external,
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
            ProfileNavBar(viewModel: viewModel)
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
                        typeOfMakeEventView: .edit,
                        event: event
                    )
                )
                .onDisappear {
                    viewModel.updateEvents()
                }
            }
        }
        .alert(
            "указана неверная ссылка",
            isPresented: $viewModel.invalidLink
        ) {
            Button("ок", role: .cancel) { }
        }
        .onAppear {
            viewModel.updateEvents()
        }
    }

}

#Preview {
    ProfileView()
}
