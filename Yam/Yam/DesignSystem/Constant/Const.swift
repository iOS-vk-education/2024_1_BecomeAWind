import UIKit
import SwiftUI

enum Const {
    /// screen
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    static let topSafeAreaSize = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
    static let bottomSafeAreaSize = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0

    static let headerTextFont = FontManager.getFont(
        with: .bold,
        and: 35
    )
    static let buttonFont = FontManager.getFont(
        with: .bold,
        and: 17
    )
    static let fontSize: CGFloat = 20
    static let regularFontSize: CGFloat = 15
    static let cornerRadius: CGFloat = 20
    static let sideSpace: CGFloat = 15

    /// circle button
    static let circleButtonSize = screenWidth * 0.08
    static let circleButtonCornerRadius = circleButtonSize / 2

    /// animations
    static let tabBarItemSwapAnimation = Animation.timingCurve(0.4, 0, 0.2, 1, duration: 0.2)

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
