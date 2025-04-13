import UIKit

struct Event: Identifiable, Hashable {
    var id = UUID()
    var image: UIImage
//    let description: String?
    var title: String
    var seats: Seats
    var link: String
    var date: Date
    var place: Place
    
    init?(title: String, seats: Seats, link: String, image: UIImage, date: Date, place: Place) {
        self.title = title
        self.seats = seats
        self.link = link
        self.image = image
        self.date = date
        self.place = place
    }
    
    init?(data: [String: Any]) {
        guard
            let title = data["title"] as? String,
            let seats = data["seats"] as? Seats,
            let place = data["place"] as? Place,
            let link = data["link"] as? String,
            let image = data["image"] as? UIImage,
            let date = data["date"] as? Date
        else {
            return nil
        }
        
//        let description = data["description"] as? String
        
        self.id = UUID()
        self.title = title
        self.seats = seats
        self.link = link
        self.image = image
        self.date = date
        self.place = place
    }
        
        
//        init?(data: [String: Any] ) {
//        guard
//            let title = data["title"] as? String
//        else {
//            return nil
//        }
//
//        let place = data["place"] as? Place
//        let link = data["link"] as? String
//        let image = data["image"] as? UIImage
//        let date = data["date"] as? Date
//        let seats = data["seats"] as? Seats
//        let body = data["description"] as? String
//        let description = data["description"] as? String
//
//        self.title = title
//        self.description = description
//        if let seats = seats { self.seats = seats } else { return nil }
//        if let place = place { self.place = place } else { return nil }
//        if let link = link { self.link = link } else { return nil }
//        if let image = image { self.image = image } else { return nil }
//        if let date = date { self.date = date } else { return nil }
}
