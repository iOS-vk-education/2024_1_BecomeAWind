import SwiftUI
import _PhotosUI_SwiftUI

struct CreateEventImage: View {
    @Binding var image: UIImage
    @State private var photosPickerItem: PhotosPickerItem?

    var body: some View {
        HStack {
            Spacer()
            VStack {
                YamImage(image: image)
                PhotosPicker(selection: $photosPickerItem, matching: .images) {
                    YamCapsuleLabel(title: "выбрать обложку")
                }
                .onChange(of: photosPickerItem) {
                    Task {
                        if let photosPickerItem,
                           let data = try? await photosPickerItem.loadTransferable(type: Data.self) {
                            if let img = UIImage(data: data) {
                                image = img
                            }
                        }
                        photosPickerItem = nil
                    }
                }
            }
            Spacer()
        }
        .padding(.bottom)
    }
}

