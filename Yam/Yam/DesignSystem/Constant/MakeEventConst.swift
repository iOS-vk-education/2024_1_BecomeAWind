import Foundation

enum MakeEventConst {

    /// image picker
    static let imageSize: CGFloat = Const.screenWidth * 0.6

    /// text fields
    static let titleMaxLength = Int(Const.screenHeight * 0.1)
    static let seatsMaxLength = 4
    static let contactMaxLength = Int(Const.screenHeight * 0.4)
    static let lineLimit = 10

    /// place picker
    static let emptyPlaceText = "выбери место проведения ивента"

    /// fonts
    static let sectionTitleFont = FontManager.getFont(with: .semibold, and: 17)
    static let sectionEmptyFont = FontManager.getFont(with: .regular, and: 15)

}

