import SwiftUI

enum EntryFont {
    static let tabBarItemTitleFont: Font = FontManager.getFont(
        with: .medium,
        and: EntryConst.tabBarItemTitleFontSize
    )
}
