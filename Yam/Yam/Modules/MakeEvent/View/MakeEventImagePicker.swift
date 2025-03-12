import SwiftUI
import _PhotosUI_SwiftUI

struct MakeEventImagePicker: View {
    @ObservedObject var viewModel: MakeEventViewModel

    var body: some View {
        HStack {
            Spacer()
            VStack {
                YImage(image: viewModel.image, size: MakeEventConst.imageSize)
                PhotosPicker(selection: $viewModel.photosPickerItem, matching: .images) {
                    YCapsuleLabel(
                        title: "выбери превью",
                        font: Const.buttonFont
                    )
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
