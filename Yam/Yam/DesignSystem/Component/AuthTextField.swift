import UIKit

// MARK: - Макет для текстовых полей
class AuthTextField: UITextField {

    enum AuthTextFieldType {
        case login
        case email
        case password
    }

    init(fieldType: AuthTextFieldType) {
        super.init(frame: .zero)

        self.backgroundColor = .secondarySystemBackground
        self.layer.cornerRadius = 10
        self.returnKeyType = .done
        self.autocorrectionType = .no
        self.autocapitalizationType = .none

        self.leftViewMode = .always
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.size.height))
        self.translatesAutoresizingMaskIntoConstraints = false

        switch fieldType {
        case .login:
            self.placeholder = "Имя пользователя"
        case .email:
            self.placeholder = "Почта"
            self.keyboardType = .emailAddress
            self.textContentType = .emailAddress
        case .password:
            self.placeholder = "Пароль"
            self.textContentType = .oneTimeCode
            self.isSecureTextEntry = true
        }

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
