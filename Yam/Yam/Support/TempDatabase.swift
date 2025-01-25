import SwiftUI
import MapKit

class TempDatabase: ObservableObject {
    static let shared = TempDatabase()

    private init() {
        print("TempDatabase initialized")
    }

    @Published var events: [Event] = [
//        Event(title: "Basketball",
//              description: """
//                Need 1+ person for a game of “33”,
//                want to play but don’t know the rules - I’ll explain, just come quickly,
//                I’m really bored
//                """,
//              place: "Russia, Moscow, Pushkina st., 7",
//              seats: 1,
//              contact: "@sporticus"),
//        Event(title: "Repost party",
//              description: """
//                Repost and get to our biggest party in Moscow!!
//                """,
//              place: "Russia, Moscow, Kirova st., 29",
//              seats: 100,
//              contact: "@partyman"),
//        Event(
//            title: "CS:GO team",
//            description: """
//            I want to increase my rating on Faceit properly, I need teammates!!
//            """,
//            place: "Russia, Moscow",
//            seats: 4,
//            contact: "@deadinside"
//        )
    ]

    @Published var location1 = CLLocation(latitude: 55.9558,
                                         longitude: 37.2173)
    @Published var location2 = CLLocation(latitude: 55.5568,
                                         longitude: 37.1143)
    @Published var location3 = CLLocation(latitude: 55.0598,
                                         longitude: 37.4103)
}
