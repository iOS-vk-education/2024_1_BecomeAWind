import UIKit

extension UIViewController {
    // Скрыть клавиатуру по тапу на пустое место
    func hideKeyboardByTapOnVoid() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.hideKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}
