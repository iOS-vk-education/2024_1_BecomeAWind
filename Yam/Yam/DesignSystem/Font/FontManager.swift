import SwiftUI

enum FontManager {
    enum FontWeight {
        case extrabold
        case bold
        case semibold
        case medium
        case regular
    }

    enum CoreFont {
        static let extrabold = "MontserratAlternates-ExtraBold"
        static let bold = "MontserratAlternates-Bold"
        static let semibold = "MontserratAlternates-SemiBold"
        static let medium = "MontserratAlternates-Medium"
        static let regular = "MontserratAlternates-Regular"
    }

    static let def: Font = getFont(with: .regular, and: 20)

    static func getFont(with fontWeight: FontWeight, and fontSize: CGFloat) -> Font {
        var font: Font

        switch fontWeight {
        case .extrabold: font = Font.custom(CoreFont.extrabold, size: fontSize)
        case .bold: font = Font.custom(CoreFont.bold, size: fontSize)
        case .semibold: font = Font.custom(CoreFont.semibold, size: fontSize)
        case .medium: font = Font.custom(CoreFont.medium, size: fontSize)
        case .regular: font = Font.custom(CoreFont.regular, size: fontSize)
        }

        return font
    }
}


