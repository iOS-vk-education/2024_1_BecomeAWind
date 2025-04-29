import Foundation
import FirebaseFirestore

protocol TableFetchDataProtocol {

    associatedtype Item

    var isLoadingMore: Bool { get set }
    var isRefreshing: Bool { get set }
    var lastDoc: DocumentSnapshot? { get set }
    var isEndReached: Bool { get set }

    func loadInitialItems() async
    func loadNextPackItemsIfNeeded(currentItem item: Item) async
    func refresh() async

}
