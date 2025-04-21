import Foundation

protocol NavBarViewModelProtocol: ObservableObject {

    associatedtype Tab: Equatable, RawRepresentable where Tab.RawValue == String

    var leftTab: Tab { get }
    var rightTab: Tab { get }
    var activeTab: Tab { get }

    var isVisibleCenterButton: Bool { get }

    func changeActiveTabTo(_ tab: Tab)

}

extension NavBarViewModelProtocol {

    func centerButtonAction() {}

}
