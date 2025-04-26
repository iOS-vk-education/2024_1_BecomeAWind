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

    func edit(_ event: Event, with flags: EditEventFlags) {
        guard let userID = authInteractor.getUserID() else {
            Logger.BuildEvent.eventEditFail()
            return
        }

        var dct = [String: Any]()

        if flags.imageChanged {
            dct["imagePath"] = event.imagePath
        }

        if flags.titleChanged {
            dct["title"] = event.title
        }

        if flags.allSeatsChanged {
            dct["seats.all"] = event.seats.all
        }

        if flags.linkChanged {
            dct["link"] = event.link
        }

        if flags.dateChanged {
            dct["date"] = event.date
        }

        if flags.geopointChanged {
            dct["place.geopoint"] = event.place.geopoint
        }

        dbService.editEventFor(userID: userID, dictToEdit: dct)
        Logger.BuildEvent.eventEditSuccess()
    }

}
