import UIKit

extension UIViewController {
    // Скрыть клавиатуру по тапу на пустое место
    func hideKeyboardByTapOnVoid() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.hideKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}

class Src {
    enum Color {
        static let purple =  #colorLiteral(red: 0.6791635156, green: 0.260504663, blue: 0.8906775117, alpha: 1)
        static let green =  #colorLiteral(red: 0.1280630529, green: 0.9192457795, blue: 0.4505957961, alpha: 1)
        static let dark =  #colorLiteral(red: 0.1678080261, green: 0.2380830348, blue: 0.3642245829, alpha: 1)
    }

    enum Sizes {
        static let space085: CGFloat = 0.85
        static let space10: CGFloat = 10
        static let space15: CGFloat = 15
        static let space20: CGFloat = 20
        static let space30: CGFloat = 30
        static let space40: CGFloat = 40
        static let space50: CGFloat = 50
        static let space55: CGFloat = 55
        static let space70: CGFloat = 70
        static let space200: CGFloat = 200
    }

    static func setHideKeyboard(view: UIView, hideKeyboard: UIButton) {
        view.addSubview(hideKeyboard)
        hideKeyboard.setImage(UIImage(named: "hidek"), for: .normal)
        hideKeyboard.layer.cornerRadius = 25
        hideKeyboard.isHidden = true
        hideKeyboard.backgroundColor = Src.Color.purple
    }

    static func setHideKeyboardPosition(view: UIView, hideKeyboard: UIButton) {
        hideKeyboard.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            hideKeyboard.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -10),
            hideKeyboard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            hideKeyboard.widthAnchor.constraint(equalToConstant: 50),
            hideKeyboard.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
