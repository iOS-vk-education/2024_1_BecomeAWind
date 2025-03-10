import Foundation
import SwiftUI

final class CreateEventModel {

    private var tempDatabase = TempDatabase.shared

    func createEvent(_ event: Event) {
        tempDatabase.myEvents.append(event)
        print(tempDatabase.myEvents)
    }

}
