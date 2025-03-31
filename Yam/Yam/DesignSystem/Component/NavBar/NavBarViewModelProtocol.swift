import Foundation

protocol NavBarViewModelProtocol: ObservableObject {

    associatedtype Tab: Equatable, RawRepresentable where Tab.RawValue == String

    var leftTab: Tab { get }
    var rightTab: Tab { get }
    var activeTab: Tab { get }

    func changeActiveTabTo(_ tab: Tab)

    func centerButtonAction()

}
