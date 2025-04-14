import SwiftUI
import CoreLocation

final class EntryViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {

    enum LocationAuthStatus {
        case notDetermined
        case access
        case restricted
    }

    struct EntryTabItemConfiguration: Identifiable {
        let id = UUID()
        var tab: EntryTab
        var title: String
        var imageName: String
    }

    override init() {
        super.init()

        locationManager.delegate = self
        tabs = [
            EntryTabItemConfiguration(tab: .profile, title: "профиль", imageName: "person.crop.circle"),
            EntryTabItemConfiguration(tab: .search, title: "поиск", imageName: "widget.small"),
            EntryTabItemConfiguration(tab: .map, title: "карта", imageName: "map")
        ]
    }

    private let locationManager = CLLocationManager()
    private(set) var tabs: [EntryTabItemConfiguration] = []
    @Published var activeTab: EntryTab = .profile
    @Published var isLocationServicesEnabled = false
    @Published var authStatus: LocationAuthStatus = .notDetermined
    @Published var opacityOfOpenSettingsView: Double = 0

}

extension EntryViewModel {

    func changeActive(to tab: EntryTab) {
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

// MARK: - location manager logic
extension EntryViewModel {
    
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

