import Foundation
import FirebaseAuth

final class AuthService {

    static let shared = AuthService()
    private let auth = Auth.auth()
    private let dbService = DatabaseService.shared

    private init() {}



}

extension AuthService {

    var currentUser: User? {
        auth.currentUser
    }

    func signUp(
        email: String,
        password: String,
        completion: @escaping (Result<User, Error>) -> Void
    ) {
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            if let result {
                let user = YUser(id: result.user.uid,
                                 email: email,
                                 password: password)
                self?.dbService.createUser(user: user) { dbResult in
                    switch dbResult {
                    case .success(_):
                        completion(.success(result.user))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            } else if let error {
                completion(.failure(error))
            }
        }
    }

    func signIn(
        email: String,
        password: String,
        completion: @escaping (Result<User, Error>) -> Void
    ) {
        auth.signIn(withEmail: email, password: password) { result, error in
            if let result {
                completion(.success(result.user))
            } else if let error {
                completion(.failure(error))
            }
        }
    }

}
