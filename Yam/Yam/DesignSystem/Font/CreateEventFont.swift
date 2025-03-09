import SwiftUI

enum CreateEventFont {

    /// title
    static let headerTextFont = FontManager.getFont(with: .bold, and: Const.headerFontSize)

    /// image picker, place picker
    static let chooseButtonFont = FontManager.getFont(
        with: .medium,
        and: 17
    )

    /// sections
    static let sectionTitleFont = FontManager.getFont(
        with: .semibold,
        and: 17
    )
    static let sectionContentFont = FontManager.getFont(with: .regular, and: Const.regularFontSize)
    
}
