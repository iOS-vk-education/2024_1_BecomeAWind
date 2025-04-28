import _PhotosUI_SwiftUI
import SwiftUI
import MapKit
import FirebaseFirestore

final class BuildEventViewModel: NSObject, ObservableObject {

    private let model = BuildEventModel()
    private let imageService = ImageService.shared
    private let uiConfig: BuildEventUIConfig
    let buildEventType: BuildEventType
    var event: Event?

    /// header
    var headerText: String = ""

    /// image picker
    @Published private(set) var image: UIImage = UIImage(named: "default_event_image") ?? UIImage()
    @Published var photosPickerItem: PhotosPickerItem?
    var imagePickerButtonText = ""
    private var imageChangedFlag = false

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

    /// handle event
    @Published var isBuildingEventLoaderFlag = false
    @Published var eventCreationFailed = false
    @Published var eventEditionFailed = false
    var footerButtonText: String = ""

    init(
        builtEventType: BuildEventType = .create,
        event: Event? = nil
    ) {
        self.buildEventType = builtEventType
        self.event = event
        uiConfig = BuildEventUIConfig(type: builtEventType, event: event)
        super.init()
        applyUIConfig()
    }

    private func applyUIConfig() {
        headerText = uiConfig.headerText
        imagePickerButtonText = uiConfig.imagePickerButtonText
        eventTitle = uiConfig.eventTitle
        allSeats = uiConfig.allSeats
        link = uiConfig.link
        date = uiConfig.date
        placeDescription = uiConfig.placeDescription
        location = uiConfig.location
        footerButtonText = uiConfig.footerButtonText
    }

}

// MARK: - Handle event

extension BuildEventViewModel {

    func handleEvent() async -> Bool {
        await MainActor.run { isBuildingEventLoaderFlag = true }
        defer {
            Task { @MainActor in
                isBuildingEventLoaderFlag = false
            }
        }

        var result: Bool

        if buildEventType == .create {
            result = await createEvent()
        } else {
            result = await editEvent()
        }

        return result
    }

    func toggleEventHandlingFailed() {
        buildEventType == .create
        ? eventCreationFailed.toggle()
        : eventEditionFailed.toggle()
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

// MARK: - Create event

extension BuildEventViewModel {

    private func createEvent() async -> Bool {
        guard canCreate(),
              let imagePath = await getImagePath() else { return false }

        model.create(prepareEventForCreate(with: imagePath))

        return true
    }

    private func canCreate() -> Bool {
        var result = false

        if !eventTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
            !link.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
            placeDescription != BuildEventConst.emptyPlaceText &&
            location != nil {
            result = true
        }

        return result
    }

    private func prepareEventForCreate(with imagePath: String) -> Event {
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

}

// MARK: - Edit event

extension BuildEventViewModel {

    func imageChanged() {
        imageChangedFlag = true
    }

    private func editEvent() async -> Bool {
        guard let event = event else { return false }
        if isOldEqualNew(oldEvent: event) { return true }
        if !canEdit(oldEvent: event) { return false }

        var imagePath = ""
        if imageChangedFlag {
            guard let path = await getImagePath() else { return false }
            imagePath = path
        } else {
            imagePath = event.imagePath
        }

        await model.edit(prepareEventForEdit(with: imagePath, oldEvent: event))

        return true
    }

    private func isOldEqualNew(oldEvent: Event) -> Bool {
        guard let location = location,
              let allSeats = Int(allSeats) else { return false }

        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        let geopoint = GeoPoint(latitude: latitude, longitude: longitude)

        return !imageChangedFlag &&
        eventTitle == oldEvent.title &&
        allSeats == oldEvent.seats.all &&
        link == oldEvent.link &&
        date == oldEvent.date &&
        geopoint == oldEvent.place.geopoint
    }

    private func canEdit(oldEvent: Event) -> Bool {
        !eventTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !link.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        Int(allSeats) ?? 1 >= oldEvent.seats.all &&
        placeDescription != BuildEventConst.emptyPlaceText &&
        placeDescription != BuildEventConst.placeFailText &&
        location != nil
    }

    private func prepareEventForEdit(with imagePath: String, oldEvent: Event) -> Event {
        let seats = Seats(busy: oldEvent.seats.busy, all: Int(allSeats) ?? 1)

        let geopoint = GeoPoint(
            latitude: location?.coordinate.latitude ?? 0.0,
            longitude: location?.coordinate.latitude ?? 0.0
        )
        let place = Place(geopoint: geopoint, description: placeDescription)

        let event = Event(
            id: oldEvent.id,
            imagePath: imagePath,
            title: eventTitle,
            seats: seats,
            link: link,
            date: date,
            place: place
        )

        return event
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

        await MainActor.run {
            if description != BuildEventConst.placeFailText {
                placeDescription = description
                location = loc
                return true
            } else {
                placeDescription = BuildEventConst.emptyPlaceText
                location = nil
                return false
            }
        }

        return description != BuildEventConst.placeFailText
    }

}
