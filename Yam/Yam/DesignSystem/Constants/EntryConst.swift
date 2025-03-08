import UIKit
import SwiftUI

enum EntryConst {
    /// Tab bar
    static let tabBarHeight = Const.screenHeight * 0.11
    static let tabBarImageSize = tabBarHeight * 0.2
    
    static let fastAnimation = Animation.timingCurve(0.4, 0, 0.2, 1, duration: 0.2)
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
