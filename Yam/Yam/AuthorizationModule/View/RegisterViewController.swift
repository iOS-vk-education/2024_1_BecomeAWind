import UIKit
import SwiftUI

final class RegisterViewController: UIViewController {
    private let headerView = AuthHeaderView(title: "Регистрация")
    private let loginTextField = AuthTextField(fieldType: .login)
    private let emailTextField = AuthTextField(fieldType: .email)
    private let passwordTextField = AuthTextField(fieldType: .password)
    private let signUpButton = AuthButton(title: "Создать аккаунт", hasBackground: true, fontSize: .big)
    private let iHaveAnAccount = AuthButton(title: "У меня есть аккаунт", hasBackground: false, fontSize: .med)
    @ObservedObject var tempDatabase = TempDatabase.shared

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setActions()
        hideKeyboardByTapOnVoid()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
}

// MARK: - Actions
extension RegisterViewController {
    private func setActions() {
        signUpButton.addTarget(self, action: #selector(tapSignUp), for: .touchUpInside)
        iHaveAnAccount.addTarget(self, action: #selector(tapIHaveNoAccount), for: .touchUpInside)
    }

    @objc func tapSignUp() {
        if (emailTextField.text ?? "") == "" ||
            (passwordTextField.text ?? "") == "" ||
            (loginTextField.text ?? "") == "" {
            showErrorAlert()
        } else {
            let mainView = MainView()
            let hostingController = UIHostingController(rootView: mainView)
            navigationController?.pushViewController(hostingController, animated: true)
        }
    }

    @objc func tapIHaveNoAccount() {
        self.navigationController?.popToRootViewController(animated: true)
    }

    private func showErrorAlert() {
        let alert = UIAlertController(title: "Ошибка", message: "Введите все поля", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - Support functions
extension RegisterViewController {
    /*
    private func validateUsersList(userCollection: CollectionReference,
                              login: String,
                              email: String,
                              completion: @escaping (Bool?, Bool?, Error?) -> Void) {
        userCollection.getDocuments { (querySnapshot, error) in
            var loginValid = true
            var emailValid = true
            
            if let error = error {
                completion(nil, nil, error)
            }
            
            guard let documents = querySnapshot?.documents else {
                print("Документы отсутствуют")
                return
            }
            
            for document in documents {
                let documentData = document.data()
                
                for (key, value) in documentData {
                    if key == "login" && value as! String == login {
                        print(key, value)
                        loginValid = false
                    }
                    
                    if key == "email" && value as! String == email {
                        print(key, value)
                        emailValid = false
                    }
                }
            }
        
            completion(loginValid, emailValid, nil)
        }
    }
    */

    private func isValidEmail(email: String) -> Bool {
        let email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.{1}[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    private func isValidLogin(login: String) -> Bool {
        return login.isEmpty
    }

    private func isValidPassword(password: String) -> Bool {
        let password = password.trimmingCharacters(in: .whitespacesAndNewlines)
        let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[$@$#!%*?&]).{6,32}$"
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: password)
    }
}

// MARK: - UI
extension RegisterViewController {
    private func setUI() {
        view.backgroundColor = .systemBackground

        view.addSubview(headerView)
        view.addSubview(loginTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signUpButton)
        view.addSubview(iHaveAnAccount)

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: Src.Sizes.space200),

            loginTextField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: Src.Sizes.space15),
            loginTextField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            loginTextField.heightAnchor.constraint(equalToConstant: Src.Sizes.space55),
            loginTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Src.Sizes.space085),

            emailTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: Src.Sizes.space15),
            emailTextField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: Src.Sizes.space55),
            emailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Src.Sizes.space085),

            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: Src.Sizes.space15),
            passwordTextField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: Src.Sizes.space55),
            passwordTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Src.Sizes.space085),

            signUpButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: Src.Sizes.space15),
            signUpButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: Src.Sizes.space55),
            signUpButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Src.Sizes.space085),

            iHaveAnAccount.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: Src.Sizes.space10),
            iHaveAnAccount.centerXAnchor.constraint(equalTo: headerView.centerXAnchor)
        ])
    }
}
