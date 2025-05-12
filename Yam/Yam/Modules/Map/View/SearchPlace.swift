import SwiftUI
import MapKit

struct SearchPlace: Identifiable {
    let id = UUID()
    let mapItem: MKMapItem
}
