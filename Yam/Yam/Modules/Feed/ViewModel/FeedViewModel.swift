import Foundation
import Combine
import SwiftUI

final class FeedViewModel: ObservableObject {

    @ObservedObject var db = TempDatabase.shared
    private var model = MakeEventModel()

}

extension FeedViewModel: YEventCardProtocol {

    func toggleEditEvent(for event: Event) {
//        print(#function)
    }

    func toggleEventLocation(for event: Event) {
//        print(#function)
    }

    func openLink(_ link: String) {
//        print(#function)
    }

    func getSeatsString(from seats: Seats) -> String {
        EventHandler.getSeatsString(from: seats)
    }

    func getDateString(from date: Date) -> String {
        EventHandler.getDateString(from: date)
    }

}
