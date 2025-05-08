import UIKit
import SwiftUI
import FirebaseFirestore
import MapKit
import GeoFireUtils

enum Const {

    // screen
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    static let topSafeAreaSize = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
    static let bottomSafeAreaSize = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0

    static let headerTextFont = FontManager.getFont(with: .bold, and: 35)
    static let buttonFont = FontManager.getFont(with: .bold, and: 17)
    static let placeDescriptionFont = FontManager.getFont(with: .medium, and: 15)

    static let fontSize: CGFloat = 20
    static let cornerRadius: CGFloat = 20
    static let sideSpace: CGFloat = 15

    // map
    static let eventImageSize = Const.screenWidth * 0.15

    // nav bar
    static let navBarHeight = Const.screenHeight * 0.13
    static let navBarItemTitleFont: Font = FontManager.getFont(with: .medium, and: 15)

    // circle button
    static let circleButtonSize = screenWidth * 0.08
    static let circleButtonCornerRadius = circleButtonSize / 2

    // square button
    static let squareButtonSize = screenWidth * 0.13
    static let squareButtonCornerRadius = squareButtonSize / 3

    // animations
    static let tabBarItemSwapAnimation = Animation.timingCurve(0.4, 0, 0.2, 1, duration: 0.2)

    // text field
    static let sectionTitleFont = FontManager.getFont(with: .semibold, and: 17)
    static let sectionEmptyFont = FontManager.getFont(with: .regular, and: 15)

    // instances
    static let defaultEvent: Event = Event(
        id: "1",
        imagePath: "1",
        title: "1",
        seats: Seats(busy: 0, all: 1),
        link: "1",
        date: Date(),
        place: Place(
            geopoint: GeoPoint(latitude: 0.0, longitude: 0.0),
            geohash: GFUtils.geoHash(forLocation: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)),
            description: "1"
        )
    )
    static let defaultEvent2: Event = Event(
        id: "2",
        imagePath: "1",
        title: "1",
        seats: Seats(busy: 0, all: 1),
        link: "1",
        date: Date(),
        place: Place(
            geopoint: GeoPoint(latitude: 0.0, longitude: 0.0),
            geohash: GFUtils.geoHash(forLocation: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)),
            description: "1"
        )
    )
    static let defaultEvent3: Event = Event(
        id: "3",
        imagePath: "1",
        title: "1",
        seats: Seats(busy: 0, all: 1),
        link: "1",
        date: Date(),
        place: Place(
            geopoint: GeoPoint(latitude: 0.0, longitude: 0.0),
            geohash: GFUtils.geoHash(forLocation: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)),
            description: "1"
        )
    )
    static let defaultGeoPoint = GeoPoint(latitude: 0.0, longitude: 0.0)

}
