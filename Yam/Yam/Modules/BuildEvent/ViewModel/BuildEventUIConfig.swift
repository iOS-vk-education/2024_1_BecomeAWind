import _PhotosUI_SwiftUI
import SwiftUI

final class BuildEventUIConfig: ObservableObject {

    let typeOfBuildEventView: TypeOfBuildEventView
    var uievent: UIEvent?

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
        typeOfBuildEventView: TypeOfBuildEventView = .create,
        event: UIEvent? = nil
    ) {
        self.typeOfBuildEventView = typeOfBuildEventView
        self.uievent = event
        initConstants()
    }

}

// MARK: - Init

extension BuildEventUIConfig {

    private func initConstants() {
        initHeaderText()
        initImage()
        initImagePicker()
        initEventTitle()
        initAllSeats()
        initLink()
        initDate()
        initPlaceDescription()
        initLocation()
        initFooterButtonText()
    }

    private func initHeaderText() {
        headerText = typeOfBuildEventView == .create ? "новый ивент" : "редактирование ивента"
    }

    private func initImage() {
        image = typeOfBuildEventView == .create
        ? UIImage(named: "default_event_image") ?? UIImage(systemName: "photo.artframe")!
        : uievent?.image ?? UIImage(systemName: "photo.artframe")!
    }

    private func initImagePicker() {
        imagePickerButtonText = typeOfBuildEventView == .create ? "выбери превью" : "измени превью"
    }

    private func initEventTitle() {
        eventTitle = typeOfBuildEventView == .create ? "" : uievent?.title ?? ""
    }

    private func initAllSeats() {
        allSeats = typeOfBuildEventView == .create ? "1" : String(uievent?.seats.all ?? 1)
    }

    private func initLink() {
        link = typeOfBuildEventView == .create ? "" : uievent?.link ?? ""
    }

    private func initDate() {
        date = typeOfBuildEventView == .create ? Date() : uievent?.date ?? Date()
    }

    private func initPlaceDescription() {
        placeDescription = typeOfBuildEventView == .create
        ? BuildEventConst.emptyPlaceText
        : uievent?.place.placeDescription ?? BuildEventConst.emptyPlaceText
    }

    private func initLocation() {
        location = typeOfBuildEventView == .create ? nil : uievent?.place.location ?? nil
    }

    private func initFooterButtonText() {
        footerButtonText = typeOfBuildEventView == .create ? "создать ивент" : "обновить ивент"
    }

}
