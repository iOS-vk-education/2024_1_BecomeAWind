import SwiftUI

struct EntryView: View {
    @StateObject private var viewModel = EntryViewModel()
    @StateObject var locationManager = LocationServicesStatusManager()

    var body: some View {
        ZStack {
            if locationManager.isLocationServicesEnabled {
                switch viewModel.activeTab {
                case .profile:
                    ProfileView()
                case .search:
                    FeedView()
                case .map:
                    MapView()
                }

                EntryTabBar(viewModel: viewModel)
            } else {
                DisabledLocationServicesView(
                    locationManager: locationManager
                )
            }


        }
        .edgesIgnoringSafeArea(.bottom)
    }

}


#Preview {
    EntryView()
}
