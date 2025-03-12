import Foundation
import SwiftUI

final class MakeEventModel {

    private var tempDatabase = TempDatabase.shared

    func createEvent(_ event: Event) {
        tempDatabase.myEvents.append(event)
    }

    func editEvent(_ event: Event?) {
        if let event {
            for (i, nowEvent) in tempDatabase.myEvents.enumerated() {
                if nowEvent.id == event.id {
                    tempDatabase.myEvents[i] = event
                }
            }
        }
    }

}
