import UIKit

enum Const {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height

    static let headerFontSize: CGFloat = 35
    static let fontSize: CGFloat = 20
    static let regularFontSize: CGFloat = 15
    static let cornerRadius: CGFloat = 20
    static let sideSpace: CGFloat = 15

    /// circle button
    static let buttonSize = screenWidth * 0.08
    static let buttonCornerRadius = buttonSize / 2
}


public enum SizePack {
    static let coreFontSize: CGFloat = 20


    static let textFieldFontSize: CGFloat = 15

    static let tabBarItemSize: CGFloat = 25
    static let mediumImageSize: CGFloat = 200
    static let smallImageSize: CGFloat = 20
    static let coreSideSpacing: CGFloat = 20
    static let coreCornerRadius: CGFloat = 20
}
