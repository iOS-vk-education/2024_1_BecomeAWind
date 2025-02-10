import SwiftUI
import MapKit

final class TempDatabase: ObservableObject {
    static let shared = TempDatabase()
    @Published var events: [Event] = []
    @Published var users: [UserModel] = [
        UserModel(login: "1", email: "1", password: "1"),
        UserModel(login: "2", email: "2", password: "2"),
        UserModel(login: "3", email: "3", password: "3")
    ]

    private init() {
        print("TempDatabase initialized")
        for i in 0..<10 {
            generateEvents()
        }
    }

    func generateEvents() {
        let coordinate = CLLocationCoordinate2D(latitude: 55.7558, longitude: 37.6173)
        let eventDate = DateModel(date: Date(), timeZone: TimeZone.current)
        let seats = 200
        let link = "https://github.com/ilyansky/born2code"

        let eventDescription = EventDescription(title: "Концерт в Москве", description: "Уникальное музыкальное событие в центре Москвы.", image: UIImage(named: "projectx")!)
        let eventOrganization = EventOrganizationInformation(date: eventDate,
                                                             seats: seats,
                                                             link: link)
        let event = Event(description: eventDescription,
                          organization: eventOrganization)
        events.append(event)
    }

    @Published var location1 = CLLocation(latitude: 55.9558,
                                         longitude: 37.2173)
    @Published var location2 = CLLocation(latitude: 55.5568,
                                         longitude: 37.1143)
    @Published var location3 = CLLocation(latitude: 55.0598,
                                         longitude: 37.4103)
}
