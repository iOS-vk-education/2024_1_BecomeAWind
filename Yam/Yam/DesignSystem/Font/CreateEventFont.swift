import SwiftUI

enum CreateEventFont {
    /// title
    static let headerTextFont = FontManager.getFont(with: .bold, and: Const.headerTextFontSize)

    /// image picker
    static let choosePhotoTextFont = FontManager.getFont(
        with: .medium,
        and: CreateEventConst.choosePhotoTextFontSize
    )

    /// text field
    static let textFieldTitleFont = FontManager.getFont(
        with: .semibold,
        and: CreateEventConst.textFieldTitleFontSize
    )
    static let textFieldFont = FontManager.getFont(with: .regular, and: Const.textFieldFontSize)
}
