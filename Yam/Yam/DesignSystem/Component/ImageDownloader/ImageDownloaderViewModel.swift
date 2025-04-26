import SwiftUI

final class ImageDownloaderViewModel: ObservableObject {

    @Published var loadFail = false

    func loadFailed() {
        loadFail = true
    }

}
