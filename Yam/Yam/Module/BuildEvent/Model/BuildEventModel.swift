import Foundation
import SwiftUI

final class BuildEventModel {

    private let dbService = DatabaseService.shared
    private let authInteractor = AuthInteractor.shared

    func create(_ preparedEvent: Event) async -> Bool {
        guard let userID = authInteractor.getUserID() else {
            Logger.BuildEvent.eventCreateFail(nil)
            return false
        }

        return await dbService.addEventFor(userID: userID, event: preparedEvent)
    }

    func edit(_ preparedEvent: Event) async -> Bool {
        guard let userID = authInteractor.getUserID() else {
            Logger.BuildEvent.eventEditFail(nil)
            return false
        }

        return await dbService.editEventFor(userID: userID, event: preparedEvent)
    }

    func delete(_ event: Event) async -> Bool {
        guard let userID = authInteractor.getUserID() else {
            Logger.BuildEvent.eventDeleteFail(nil)
            return false
        }

        return await dbService.deleteEventFor(userID: userID, event: event)
    }

}
