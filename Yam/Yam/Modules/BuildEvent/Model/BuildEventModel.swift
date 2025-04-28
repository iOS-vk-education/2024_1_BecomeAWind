import Foundation
import SwiftUI

final class BuildEventModel {

    private var db = TempDatabase.shared
    private let dbService = DatabaseService.shared
    private let authInteractor = AuthInteractor.shared

    func create(_ preparedEvent: Event) -> Bool {
        guard let userID = authInteractor.getUserID() else {
            Logger.BuildEvent.eventCreateFail()
            return false
        }

        dbService.addEventFor(userID: userID, event: preparedEvent)
        Logger.BuildEvent.eventCreateSuccess()
        return true
    }

    func edit(_ preparedEvent: Event) async -> Bool {
        guard let userID = authInteractor.getUserID() else {
            return false
        }

        return await dbService.editEventFor(userID: userID, event: preparedEvent)
    }

    func delete(_ event: Event) async -> Bool {
        guard let userID = authInteractor.getUserID() else {
            return false
        }

        return await dbService.deleteEventFor(userID: userID, event: event)
    }

}
