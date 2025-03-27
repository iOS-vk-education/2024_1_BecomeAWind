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
        switch fontWeight {
        case .extrabold: Font.custom(CoreFont.extrabold, size: fontSize)
        case .bold: Font.custom(CoreFont.bold, size: fontSize)
        case .semibold: Font.custom(CoreFont.semibold, size: fontSize)
        case .medium: Font.custom(CoreFont.medium, size: fontSize)
        case .regular: Font.custom(CoreFont.regular, size: fontSize)
        }
    }
    
}


