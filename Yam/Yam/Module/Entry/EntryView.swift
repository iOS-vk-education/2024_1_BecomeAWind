import SwiftUI
import _MapKit_SwiftUI

struct EntryView: View {
    @StateObject var locationManager = LocationManager()

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
