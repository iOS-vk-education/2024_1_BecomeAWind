import UIKit

struct Event: Identifiable, Hashable {
    var id = UUID()

    var image: UIImage?
    let description: String?
    var title: String
    var seats: Seats
    var link: String?
    var date: Date?
    var place: Place
    
//    init?(data: [String: Any] ) {
//        guard
//            let title = data["title"] as? String
//        else {
//            return nil
//        }
//        
//        let body = data["description"] as? String
//        let seats = data["seats"] as? Seats
//        let place = data["place"] as? Place
//        let link = data["link"] as? String
//        
//        
//        
//        self.title = title
//        self.body = body
//        self.seats = seats
//        self.place = place
//        self.link = link
//    }
}
