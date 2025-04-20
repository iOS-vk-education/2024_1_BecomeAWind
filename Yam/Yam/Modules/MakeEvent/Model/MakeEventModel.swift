import Foundation
import SwiftUI

final class MakeEventModel {

    private var db = TempDatabase.shared

    func create(_ event: UIEvent) {
        db.add(event: event)
    }

    func edit(_ event: UIEvent?) {
        if let event { db.edit(event: event) }
    }

}
