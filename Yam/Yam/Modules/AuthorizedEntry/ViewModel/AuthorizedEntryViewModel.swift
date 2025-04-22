import SwiftUI
import CoreLocation

final class AuthorizedEntryViewModel: NSObject, ObservableObject {

    private let locationManager = CLLocationManager()
    private(set) var tabs: [AuthorizedEntryTabItemConfig] = []
    private var navManager: NavigationManager

    @Published var activeTab: AuthorizedEntryTab = .events
    @Published var isLocationServicesEnabled = false
    @Published var authStatus: LocationAuthStatus = .notDetermined
    @Published var opacityOfOpenSettingsView: Double = 0

    init(navManager: NavigationManager) {
        self.navManager = navManager

        super.init()

        locationManager.delegate = self

        tabs = [
            AuthorizedEntryTabItemConfig(tab: .events, title: "ивенты", imageName: "mail.stack"),
            AuthorizedEntryTabItemConfig(tab: .feed, title: "поиск", imageName: "magnifyingglass.circle"),
            AuthorizedEntryTabItemConfig(tab: .map, title: "карта", imageName: "map"),
            AuthorizedEntryTabItemConfig(tab: .profile, title: "профиль", imageName: "person.crop.circle")
        ]
    }

}

// MARK: - Configure views

extension AuthorizedEntryViewModel {

    func makeEventsView() -> EventsView {
        let mod = EventsModel()
        let vm = EventsViewModel(model: mod)
        let view = EventsView(viewModel: vm)
        return view
    }

    func makeFeedView() -> FeedView {
        let vm = FeedViewModel()
        let view = FeedView(viewModel: vm)
        return view
    }

    func makeMapView() -> MapView {
        let vm = MapViewModel()
        let view = MapView(viewModel: vm)
        return view
    }

    func makeProfileView() -> ProfileView {
        let vm = ProfileViewModel(navManager: navManager)
        let view = ProfileView(viewModel: vm)
        return view
    }

}

// MARK: - Support

extension AuthorizedEntryViewModel {

    func changeActive(to tab: AuthorizedEntryTab) {
        activeTab = tab
    }

    func openSettings() {
        if let appSettings = URL(
            string: UIApplication.openSettingsURLString
        ) {
            UIApplication.shared.open(appSettings)
        }
    }

}

// MARK: - Location manager logic

extension AuthorizedEntryViewModel: CLLocationManagerDelegate {

    /*  Функция locationManagerDidChangeAuthorization(_ manager: CLLocationManager) принадлежит делегату CLLocationManagerDelegate. Она вызывается каждый раз когда создается объект класса CLLocationManager и когда меняется статус авторизации служб геолокации.
     https://developer.apple.com/documentation/corelocation/cllocationmanagerdelegate/locationmanagerdidchangeauthorization(_:)
     */
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorizationStatus()
    }

    private func checkLocationAuthorizationStatus() {
        authStatus = .notDetermined

        switch locationManager.authorizationStatus {
        case .notDetermined:
            authStatus = .notDetermined
            opacityOfOpenSettingsView = 0
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            authStatus = .access
            opacityOfOpenSettingsView = 0
            isLocationServicesEnabled = true
        default:
            authStatus = .restricted
            opacityOfOpenSettingsView = 1
            isLocationServicesEnabled = false
        }
    }

}

