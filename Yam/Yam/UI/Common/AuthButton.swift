import UIKit

// MARK: - Макет для кнопок на экранах авторизации
class AuthButton: UIButton {
    enum FontSize {
        case big
        case med
        case small
    }

    private let buttonActivityIndicator = UIActivityIndicatorView()

    init(title: String, hasBackground: Bool = false, fontSize: FontSize) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.layer.cornerRadius = Src.Sizes.space10
        self.layer.masksToBounds = true
        self.backgroundColor = hasBackground ? .systemPurple : .clear
        self.addSubview(buttonActivityIndicator)
        NSLayoutConstraint.activate([
            buttonActivityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonActivityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        buttonActivityIndicator.translatesAutoresizingMaskIntoConstraints = false
        buttonActivityIndicator.style = .large
        buttonActivityIndicator.color = .white

        let titleColor: UIColor = hasBackground ? .white : .systemBlue
        self.setTitleColor(titleColor, for: .normal)
        self.translatesAutoresizingMaskIntoConstraints = false

        switch fontSize {
        case .big:
            self.titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
        case .med:
            self.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        case .small:
            self.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        }
    }

    func turnOffButtonIf(_ flag: Bool, title: String) {
        if flag {
            self.setTitle("", for: .normal)
            self.isUserInteractionEnabled = false
            buttonActivityIndicator.startAnimating()
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.buttonActivityIndicator.stopAnimating()
                self.setTitle(title, for: .normal)
                self.isUserInteractionEnabled = true
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
