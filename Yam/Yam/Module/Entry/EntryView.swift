import SwiftUI
import MapKit

struct EntryView: View {
    //    @StateObject private var locationManager = LocationServicesStatusManager()
//    if locationManager.isLocationServicesEnabled {

    var body: some View {
        TabView {
            MyEventsView()
                .tabItem {
                    TabItem(imageSystemName: "shared.with.you",
                            title: "Ивенты"
                    )
                }

            FeedView()
                .tabItem {
                    TabItem(imageSystemName: "magnifyingglass",
                            title: "Поиск"
                    )
                }
        }
        .tint(ColorPack.purple)

    }
}

private struct TabItem: View {
    let imageSystemName: String
    let title: String

    var body: some View {
        VStack {
            Image(systemName: imageSystemName)
            Text(title)
        }

    }
}

#Preview {
    EntryView()
}
