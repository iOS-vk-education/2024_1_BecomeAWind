import UIKit
import CoreLocation
import FirebaseFirestore

struct Event: Identifiable, Hashable {
    var id = UUID()
    var image: UIImage = .init(systemName: "circle.fill")!
    let description: String
    var title: String
    var seats: Seats
    var link: String
    var date: Date
    var place: Place
    
    init?(description: String, title: String, seats: Seats, link: String, image: UIImage, date: Date, place: Place) {
        self.title = title
        self.seats = seats
        self.link = link
        self.image = image
        self.date = date
        self.place = place
        self.description = description
    }
    
    init?(data: [String: Any]) {
        guard
            let title = data["title"] as? String,
            let link = data["link"] as? String,
            let description = data["description"] as? String,
            let seats = data["seats"] as? [String: Int],
            let place = data["place"] as? GeoPoint,
            let placeDescription = data["placeDescription"] as? String,
            let dateTimestamp = data["date"] as? Timestamp
        else {
            print("govno")
            return nil
        }
    
//        let image = data["image"] as? UIImage
        
        if let seats = data["seats"] as? [String: Int],
           let busy = seats["busy"],
           let all = seats["all"] {
            self.seats = Seats(busy: busy, all: all)
        } else { return nil }
        
        self.place = Place(location: CLLocation(latitude: place.latitude,
                                                longitude: place.longitude),
                           placeDescription: placeDescription)
        self.date = dateTimestamp.dateValue()
        self.title = title
        self.link = link
        self.image = .init(systemName: "circle.fill")!
        self.description = description
    }
}
