import SwiftUI

enum CreateEventFont {
    /// title
    static let headerTextFont = FontManager.getFont(with: .bold, and: Const.headerFontSize)

    /// image picker
    static let choosePhotoTextFont = FontManager.getFont(
        with: .medium,
        and: CreateEventConst.choosePhotoTextFontSize
    )

    /// section - text fields, date picker
    static let sectionTitleFont = FontManager.getFont(
        with: .semibold,
        and: 17
    )
    static let sectionContentFont = FontManager.getFont(with: .regular, and: Const.regularFontSize)
}
