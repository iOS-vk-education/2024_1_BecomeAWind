import SwiftUI
import _PhotosUI_SwiftUI

struct BuildEventImagePicker: View {
    @ObservedObject var viewModel: BuildEventViewModel

    var body: some View {
        HStack {
            Spacer()
            VStack {
                YImage(image: viewModel.image, size: BuildEventConst.imageSize)
                PhotosPicker(selection: $viewModel.photosPickerItem, matching: .images) {
                    CapsuleLabel(
                        title: viewModel.imagePickerButtonText,
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
