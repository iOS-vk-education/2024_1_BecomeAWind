import Foundation

enum CreateEventConst {

    /// text fields
    static let titleMaxLength = 150
    static let seatsMaxLength = 4
    static let contactMaxLength = 200
    static let lineLimit = 10

    /// place picker
    static let emptyPlaceText = "выбери место проведения мероприятия"

    /// fonts
    static let sectionTitleFont = FontManager.getFont(
        with: .semibold,
        and: 17
    )
    static let sectionContentFont = FontManager.getFont(with: .regular, and: Const.regularFontSize)

}

