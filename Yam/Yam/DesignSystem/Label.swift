import UIKit

class Label: UILabel {
    enum Alignment {
        case center
        case left
        case right
        case justified
        case natural
    }

    enum Weight {
        case regular
        case bold
        case semibold
    }

    init(title: String = "",
         fontSize: CGFloat = Src.Sizes.space30,
         alignment: Alignment = .center,
         weight: Weight = .regular) {
        super.init(frame: .zero)
        self.text = title
        self.translatesAutoresizingMaskIntoConstraints = false

        switch alignment {
        case .center:
            self.textAlignment = .center
        case .left:
            self.textAlignment = .left
        case .right:
            self.textAlignment = .right
        case .justified:
            self.textAlignment = .justified
        case .natural:
            self.textAlignment = .natural
        }

        switch weight {
        case .regular:
            self.font = .systemFont(ofSize: fontSize, weight: .regular)
        case .bold:
            self.font = .systemFont(ofSize: fontSize, weight: .bold)
        case .semibold:
            self.font = .systemFont(ofSize: fontSize, weight: .semibold)

        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
