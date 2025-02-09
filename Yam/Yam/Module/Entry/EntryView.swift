import SwiftUI
import MapKit

struct EntryView: View {
    //    @StateObject private var locationManager = LocationServicesStatusManager()

    var body: some View {
        TabView {
            ProfileView()
                .tabItem {
                    TabItem(imageSystemName: "calendar.and.person",
                            title: "Прогресс"
                    )
                }

            DisabledLocationServicesView()
                .tabItem {
                    TabItem(imageSystemName: "globe.europe.africa.fill",
                            title: "Карта"
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
