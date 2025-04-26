struct EditEventFlags {

    var imageChanged = false
    var titleChanged = false
    var allSeatsChanged = false
    var linkChanged = false
    var dateChanged = false
    var geopointChanged = false

    func isOldEventEqualNewEvent() -> Bool {
        !imageChanged &&
        !titleChanged &&
        !allSeatsChanged &&
        !linkChanged &&
        !dateChanged &&
        !geopointChanged
    }

}

