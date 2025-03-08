import UIKit
import SwiftUI

/// Entry Module Constants
enum EntryConst {
    /// Tab Bar
    static let tabBarHeight = Const.screenHeight * 0.11
    static let tabBarImageSize = tabBarHeight * 0.2
    static let tabBarCornerRadius: CGFloat = 20

    static let fastAnimation = Animation.timingCurve(0.4, 0, 0.2, 1, duration: 0.3)
}

public enum SizePack {
    static let coreCornerRadius: CGFloat = 20
    static let coreFontSize: CGFloat = 20
    static let coreSideSpacing: CGFloat = 20

    static let headerTextFontSize: CGFloat = 35
    static let textFieldFontSize: CGFloat = 15

    static let tabBarItemSize: CGFloat = 25
    static let mediumImageSize: CGFloat = 200
    static let smallImageSize: CGFloat = 20
}
