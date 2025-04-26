import SwiftUI
import SDWebImageSwiftUI

struct ImageDownloader: View {

    let path: String
    @ObservedObject private var viewModel = ImageDownloaderViewModel()

    var body: some View {
        if viewModel.loadFail {
            Image(uiImage: UIImage(named: "default_event_image") ?? UIImage())
                .resizable()
        } else {
            WebImage(url: URL(string: path))
                .onFailure { error in
                    viewModel.loadFailed()
                    Logger.Events.loadImageFail(by: path, with: error)
                }
                .resizable()
        }
    }
    
}
