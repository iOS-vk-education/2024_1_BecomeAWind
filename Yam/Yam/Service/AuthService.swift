import Foundation
import FirebaseAuth
import FirebaseFirestore

final class AuthService {

    static let shared = AuthService()
    private let auth = Auth.auth()
    private let dbService = DatabaseService.shared

    private var currentUser: User? {
        auth.currentUser
    }

    private init() {
        Logger.Auth.printCurrentUserSession(auth.currentUser)
    }

}

extension AuthService {

    func isCurrentUserAuthorized() -> Bool {
        currentUser != nil
    }

    func signUp(
        email: String,
        password: String,
        completion: @escaping (Result<User, Error>) -> Void
    ) {
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            if let result {
                let user = YUser(
                    id: result.user.uid,
                    email: email,
                    myEvents: [
                        Event(
                            id: "1",
                            title: "title",
                            seats: Seats(busy: 5, all: 100),
                            link: "link",
                            date: Date(),
                            place: GeoPoint(latitude: 1.0, longitude: 2.0)
                        )
                    ],
                    subscriptions: []
                )
                self?.dbService.createUser(user: user) { dbResult in
                    defer {
                        Logger.Auth.printCurrentUserSession(self?.auth.currentUser)
                    }

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
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            defer {
                Logger.Auth.printCurrentUserSession(self?.auth.currentUser)
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
