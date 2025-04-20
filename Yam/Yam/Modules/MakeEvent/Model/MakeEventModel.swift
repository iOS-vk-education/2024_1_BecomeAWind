import Foundation
import SwiftUI

final class MakeEventModel {

    private var db = TempDatabase.shared
    private let dbService = DatabaseService.shared
    private let authService = AuthService.shared

    func create(event: Event) {
        if let userID = authService.getUserID() {
            dbService.addEventFor(userID: userID, event: event)
            Logger.MakeEvent.eventCreateSuccess()
            return
        }

        Logger.MakeEvent.eventCreateFail()
    }

    func edit(_ event: UIEvent?) {
        if let event { db.edit(event: event) }
    }

}
