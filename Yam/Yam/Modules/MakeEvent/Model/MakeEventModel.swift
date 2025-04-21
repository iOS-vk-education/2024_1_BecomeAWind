import Foundation
import SwiftUI

final class MakeEventModel {

    private var db = TempDatabase.shared
    private let dbService = DatabaseService.shared
    private let authService = AuthService.shared

    func create(event: Event) {
        guard let userID = authService.getUserID() else {
            Logger.MakeEvent.eventCreateFail()
            return
        }

        dbService.addEventFor(userID: userID, event: event)
        Logger.MakeEvent.eventCreateSuccess()
    }

    func edit(_ event: UIEvent?) {
        guard let event else {
            return
        }

        db.edit(event: event)
    }

}
