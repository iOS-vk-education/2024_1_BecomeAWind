import SwiftUI

struct EntryView: View {
    //    @StateObject private var locationManager = LocationServicesStatusManager()
    //    if locationManager.isLocationServicesEnabled {

    enum Tab {
        case profile
        case search
        case map
    }

    @State var activeTab: Tab = .profile

    var body: some View {
        ZStack {
            switch activeTab {
            case .profile:
                MyEventsView()
            case .search:
                FeedView()
            case .map:
                MapView()
            }

            VStack {
                Spacer()
                YamTabBar(activeTab: $activeTab)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}



#Preview {
    EntryView()
}
