import Foundation
import Combine
import SwiftUI

final class FeedViewModel: ObservableObject {

    @ObservedObject var db = TempDatabase.shared
    private var model = MakeEventModel()

}
