import SwiftUI
import _PhotosUI_SwiftUI

struct CreateEventImagePicker: View {
    @ObservedObject var viewModel: CreateEventViewModel

    var body: some View {
        HStack {
            Spacer()
            VStack {
                YamImage(image: viewModel.image)
                PhotosPicker(selection: $viewModel.photosPickerItem, matching: .images) {
                    YCapsuleLabel(title: "выбери превью", font: CreateEventFont.chooseButtonFont)
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
