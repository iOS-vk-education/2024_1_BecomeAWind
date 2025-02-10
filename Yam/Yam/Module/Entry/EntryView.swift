import SwiftUI
import MapKit

struct EntryView: View {
    @StateObject private var locationManager = LocationServicesStatusManager()

    var body: some View {
       ZStack {
           if locationManager.isLocationServicesEnabled {
               MapView()
               TabBarView()
           } else {
               DisabledLocationServicesView()
           }
       }
    }
}

 #Preview {
     EntryView()
 }
