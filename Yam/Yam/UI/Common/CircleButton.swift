import UIKit

class CircleButton: UIButton {
    init(buttonSize: CGFloat, imageNamed: String, imageColor: UIColor) {
        super.init(frame: .zero)

        self.setImage(UIImage(named: imageNamed)?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.tintColor = imageColor
        self.backgroundColor = Src.Color.dark
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = buttonSize / 2

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
