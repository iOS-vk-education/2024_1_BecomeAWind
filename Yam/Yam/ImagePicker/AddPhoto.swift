import SwiftUI

struct AddPhoto: View {
    
    @State var image = UIImage(systemName: "photo")!
    @State var isPicked = false

    var body: some View {
        ZStack{
            Rectangle()
                .frame(width: 324, height: 176)
                .cornerRadius(30)
                .foregroundColor(.darkBackground2)
            
            Button {
                isPicked.toggle()
            } label: {
                Image(systemName: "plus.circle")
                    .resizable()
                    .frame(width: 92, height: 92)
                    .foregroundStyle(.white)
            }.sheet(isPresented: $isPicked) {
                ImagePicker(image: $image)
            }
            
            if image != UIImage(systemName: "photo") {
                Button {
                    isPicked.toggle()
                } label: {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 324, height: 176)
                        .cornerRadius(30)
                }.sheet(isPresented: $isPicked) {
                    ImagePicker(image: $image)
                }
            }
        }
    }
}
