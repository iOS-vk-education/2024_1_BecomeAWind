import Foundation
import SwiftUI

final class MakeEventModel {

    private var db = TempDatabase.shared

    func create(_ event: Event) {
        db.add(event: event)
    }

    func edit(_ event: Event?) {
        if let event { db.edit(event: event) }
    }

}
