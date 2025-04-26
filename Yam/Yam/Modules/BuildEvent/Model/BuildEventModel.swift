import Foundation
import SwiftUI

final class BuildEventModel {

    private var db = TempDatabase.shared
    private let dbService = DatabaseService.shared
    private let authInteractor = AuthInteractor.shared

    func create(event: Event) {
        guard let userID = authInteractor.getUserID() else {
            Logger.BuildEvent.eventCreateFail()
            return
        }

        dbService.addEventFor(userID: userID, event: event)
        Logger.BuildEvent.eventCreateSuccess()
    }

    func edit(_ event: UIEvent?) {
        guard let event else {
            return
        }

//        db.edit(event: event)
    }

}
