import Foundation
import FirebaseFirestore

protocol TableFetchDataProtocol {

    var isLoading: Bool { get set }
    var lastDoc: DocumentSnapshot? { get set }
    var isEndReached: Bool { get set }
    var isFirstPack: Bool { get set }

    func loadItems(isFirstPack: Bool) async
    func refresh() async

}
