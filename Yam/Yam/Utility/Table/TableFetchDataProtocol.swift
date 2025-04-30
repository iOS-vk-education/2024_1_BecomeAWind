import Foundation
import FirebaseFirestore

protocol TableFetchDataProtocol {

    var isLoading: Bool { get set }
    var lastDoc: DocumentSnapshot? { get set }
    var isEndReached: Bool { get set }

    func loadItems(isInit: Bool) async
    func refresh() async

}
