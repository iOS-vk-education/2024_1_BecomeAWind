import Foundation
import FirebaseAuth

final class AuthInteractor {

    static let shared = AuthInteractor()
    private let auth = Auth.auth()
    private let dbService = DatabaseService.shared

    var currentUser: User? {
        auth.currentUser
    }

    private init() {
        Logger.Auth.printCurrentUserSession(auth.currentUser)
    }

}

extension AuthInteractor {

    func getUserID() -> String? {
        if let user = currentUser {
            return user.uid
        }

        return nil
    }

    func isCurrentUserAuthorized() -> Bool {
        currentUser != nil
    }

    func signUp(
        email: String,
        password: String,
        completion: @escaping (Result<User, Error>) -> Void
    ) {
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }

            if let result {
                let user = YUser(
                    id: result.user.uid,
                    email: email,
                    myEventsIDs: [],
                    subscriptionsIDs: []
                )
                self.dbService.createUser(user: user) { dbResult in
                    defer {
                        Logger.Auth.printCurrentUserSession(self.auth.currentUser)
                    }

                    switch dbResult {
                    case .success(_):
                        completion(.success(result.user))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
                Logger.Auth.printCurrentUserSession(self.auth.currentUser)
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
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }

            defer {
                Logger.Auth.printCurrentUserSession(self.auth.currentUser)
            }

            if let result {
                completion(.success(result.user))
            } else if let error {
                completion(.failure(error))
            }
        }
    }

    func signOut(completion: @escaping (Result<Void, Error>) -> Void) {
        defer {
            Logger.Auth.printCurrentUserSession(auth.currentUser)
        }

        do {
            try auth.signOut()
            completion(.success(Void()))
        } catch {
            completion(.failure(error))
        }
    }

}
