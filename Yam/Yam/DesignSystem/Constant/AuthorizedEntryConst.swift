import SwiftUI

enum AuthorizedEntryConst {
    
    /// tab bar
    static let tabBarHeight = Const.screenHeight * 0.11
    static let tabBarImageSize = tabBarHeight * 0.2

    /// font
    static let tabBarItemTitleFont: Font = FontManager.getFont(
        with: .medium,
        and: 15
    )
    
}
