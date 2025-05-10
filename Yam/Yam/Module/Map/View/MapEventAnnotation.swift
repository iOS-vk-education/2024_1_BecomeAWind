import SwiftUI

struct MapEventAnnotation: View {

    let imagePath: String
    let action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            EventOnMap(imagePath: imagePath)
        }
    }
    
}
