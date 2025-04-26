import _PhotosUI_SwiftUI
import SwiftUI
import MapKit
import FirebaseFirestore

final class BuildEventViewModel: NSObject, ObservableObject {

    private let model = BuildEventModel()
    private let imageService = ImageService.shared
//    private let uiconfig: BuildEventUIConfig
    let buildEventType: BuildEventType
    var event: Event?

    /// header
    var headerText: String = ""

    /// image picker
    @Published private(set) var image: UIImage = UIImage()
    @Published var photosPickerItem: PhotosPickerItem?
    var imagePickerButtonText = ""

    /// text fields
    @Published var eventTitle = ""
    @Published var allSeats = ""
    @Published var link = ""

    /// date picker
    @Published var date = Date()

    /// place picker
    @Published var isActiveBuildEventPlace = false
    @Published private(set) var centerCoordinate: CLLocationCoordinate2D?
    @Published var placeDescription = ""
    private var location: CLLocation?
    private var place: Place?

    /// handle event
    @Published var isCreatingEventLoaderFlag = false
    @Published var eventCreationFailed = false
    @Published var eventEditionFailed = false
    var footerButtonText: String = ""

    init(
        builtEventType: BuildEventType = .create,
        event: Event? = nil
    ) {
        self.buildEventType = builtEventType
        self.event = event
//        uiconfig = BuildEventUIConfig(type: builtEventType, event: event)
        super.init()
//        applyUIConfig()
    }

//    private func applyUIConfig() {
//        headerText = uiconfig.headerText
//        image = uiconfig.image
//        imagePickerButtonText = uiconfig.imagePickerButtonText
//        eventTitle = uiconfig.eventTitle
//        allSeats = uiconfig.allSeats
//        link = uiconfig.link
//        date = uiconfig.date
//        placeDescription = uiconfig.placeDescription
//        location = uiconfig.location
//        footerButtonText = uiconfig.footerButtonText
//    }

}

// MARK: - Handle event

extension BuildEventViewModel {

    func handleEvent() async -> Bool {
        await MainActor.run { isCreatingEventLoaderFlag = true }
        defer {
            Task { @MainActor in
                isCreatingEventLoaderFlag = false
            }
        }

        var result: Bool

        if buildEventType == .create {
            result = await createEvent()
        } else {
            result = editEvent()
        }

        return result
    }

    func toggleEventHandlingFailed() {
        buildEventType == .create
        ? eventCreationFailed.toggle()
        : eventEditionFailed.toggle()
    }
    
}

// MARK: - Create event

extension BuildEventViewModel {

    private func createEvent() async -> Bool {
        guard validateEventCreation(),
              let imagePath = await getImagePath() else {
            return false
        }

        model.create(event: prepareEvent(with: imagePath))

        return true
    }

    private func prepareEvent(with imagePath: String) -> Event {
        let seats = Seats(busy: 0, all: Int(allSeats) ?? 1)

        let geopoint = GeoPoint(
            latitude: location?.coordinate.latitude ?? 0.0,
            longitude: location?.coordinate.latitude ?? 0.0
        )
        let place = Place(geopoint: geopoint, description: placeDescription)

        let event = Event(
            imagePath: imagePath,
            title: eventTitle,
            seats: seats,
            link: link,
            date: date,
            place: place
        )

        return event
    }

    private func validateEventCreation() -> Bool {
        var result = false

        if !eventTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
            !link.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
            placeDescription != BuildEventConst.emptyPlaceText &&
            location != nil {
            result = true
        }

        return result
    }

    private func getImagePath() async -> String? {
        do {
            let path = try await imageService.uploadImage(image)
            return path
        } catch {
            Logger.BuildEvent.imageUploadFail()
            return nil
        }
    }

}

// MARK: - Edit event

extension BuildEventViewModel {

    private func editEvent() -> Bool {
//        let canEditEvent = validateEventEdition()
//
//        if canEditEvent {
//            let seats = Seats(busy: 0, all: Int(allSeats) ?? 1)
//            let place = Place(location: location ?? CLLocation(), placeDescription: placeDescription)
//
//            event?.imagePath = image
//            event?.title = eventTitle
//            event?.seats = seats
//            event?.link = link
//            event?.date = date
//            event?.place = place
//
//            model.edit(event)
//        }
//
//        return canEditEvent

        return false
    }

    private func validateEventEdition() -> Bool {
        var result = false
        let oldAllSeats = event?.seats.all ?? 1

        if !eventTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
            !link.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
            Int(allSeats) ?? 1 >= oldAllSeats &&
            placeDescription != BuildEventConst.emptyPlaceText &&
            location != nil {
            result = true
        }

        return result
    }

}


// MARK: - Image picker

extension BuildEventViewModel {

    func setImage() {
        Task {
            if let photosPickerItem,
               let data = try? await photosPickerItem.loadTransferable(type: Data.self),
               let image = UIImage(data: data) {

                await MainActor.run {
                    self.image = image
                }
            }

            await MainActor.run {
                self.photosPickerItem = nil
            }
        }
    }

}

// MARK: - Text field

extension BuildEventViewModel {

    func limitTextField(_ upper: Int, text: Binding<String>) {
        if text.wrappedValue.count > upper {
            text.wrappedValue = String(text.wrappedValue.prefix(upper))
        }
    }

    func filterSeats(_ newValue: String) {
        allSeats = newValue.filter { allSeats.first != "0" && $0.isNumber }
    }

}

// MARK: - Place picker

extension BuildEventViewModel: MKMapViewDelegate {

    // conformance to MKMapViewDelegate
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        DispatchQueue.main.async {
            self.centerCoordinate = mapView.centerCoordinate
        }
    }

    func toggleBuildEventPlace() {
        isActiveBuildEventPlace.toggle()
    }

}

// MARK: - Location handler

extension BuildEventViewModel {

    func updatePlaceDescription() async -> Bool {
        guard let coordinate = centerCoordinate else { return false }
        let loc = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)

        let description = await LocationHandler.getPlacemarkDescription(from: loc)

        if description != BuildEventConst.getPlacemarkDescriptionFailText {
            placeDescription = description
            location = loc
            return true
        } else {
            placeDescription = BuildEventConst.emptyPlaceText
            location = nil
            return false
        }
    }

}
