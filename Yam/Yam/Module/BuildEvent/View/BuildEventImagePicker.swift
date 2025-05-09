import SwiftUI
import _PhotosUI_SwiftUI

struct BuildEventImagePicker: View {

    @ObservedObject var viewModel: BuildEventViewModel

    var body: some View {
        HStack {
            Spacer()
            VStack {
                if viewModel.event != nil && !viewModel.imageChangedFlag {
                    ImageDownloader(path: viewModel.imagePath)
                        .scaledToFill()
                        .frame(width: BuildEventConst.imageSize, height: BuildEventConst.imageSize)
                        .clipped()
                        .cornerRadius(Const.cornerRadius)
                } else {
                    YImage(image: viewModel.image, size: BuildEventConst.imageSize)
                }

                PhotosPicker(selection: $viewModel.photosPickerItem, matching: .images) {
                    RectText(
                        text: viewModel.imagePickerButtonText,
                        font: Const.buttonFont
                    )
                }
                .onChange(of: viewModel.photosPickerItem) {
                    viewModel.setImage()
                    viewModel.imageChanged()
                }
            }
            Spacer()
        }
        .padding(.bottom)
    }
    
}
