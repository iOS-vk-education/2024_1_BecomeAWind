import Foundation
import SwiftUI

final class MakeEventModel {

    private var tempDatabase = TempDatabase.shared

    func createEvent(_ event: Event) {
        tempDatabase.myEvents.append(event)
        print(tempDatabase.myEvents)
    }

}
