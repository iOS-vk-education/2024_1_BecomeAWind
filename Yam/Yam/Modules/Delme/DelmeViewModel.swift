import Foundation
import SwiftUI
import FirebaseFirestore

final class DelmeViewModel {

    private let db = Firestore.firestore()

    init() {
        Task { await makeSubcollection() }
    }

    func makeSubcollection() async {
        let fc = db.collection("delme").document("userID")
        let sc = fc.collection("myEvents")

        let newDoc: [String: Any] = [
            "title": "event",
            "seats": 5
        ]

        do {
            try await sc.addDocument(data: newDoc)
            print(1)
        } catch {
            print(2)
        }
    }



}

