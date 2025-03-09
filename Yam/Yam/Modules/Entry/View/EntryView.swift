import SwiftUI

struct EntryView: View {
    //    @StateObject private var locationManager = LocationServicesStatusManager()
    //    if locationManager.isLocationServicesEnabled {

    @StateObject private var viewModel = EntryViewModel()

    var body: some View {
        ZStack {
            switch viewModel.activeTab {
            case .profile:
                ProfileView()
            case .search:
                FeedView()
            case .map:
                MapView()
            }

            VStack {
                Spacer()
                YTabBar(viewModel: viewModel)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
}


#Preview {
    EntryView()
}
