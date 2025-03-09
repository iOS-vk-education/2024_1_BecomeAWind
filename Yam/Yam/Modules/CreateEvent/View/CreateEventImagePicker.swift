import SwiftUI
import _PhotosUI_SwiftUI

struct CreateEventImagePicker: View {
    @ObservedObject var viewModel: CreateEventViewModel

    var body: some View {
        HStack {
            Spacer()
            VStack {
                YImage(image: viewModel.image, size: CreateEventConst.imageSize)
                PhotosPicker(selection: $viewModel.photosPickerItem, matching: .images) {
                    YCapsuleLabel(title: "выбери превью", font: Const.buttonFont)
                }
                .onChange(of: viewModel.photosPickerItem) {
                    viewModel.setImage()
                }
            }
            Spacer()
        }
        .padding(.bottom)
    }
    
}
