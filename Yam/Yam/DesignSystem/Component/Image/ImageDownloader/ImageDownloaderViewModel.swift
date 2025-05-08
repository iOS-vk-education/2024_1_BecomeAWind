import SwiftUI

final class ImageDownloaderViewModel: ObservableObject {

    @Published var loadFail = false

    func loadFailed() {
        DispatchQueue.main.async {
            self.loadFail = true
        }
    }

}
