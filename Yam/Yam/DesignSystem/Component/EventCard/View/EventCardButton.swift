import SwiftUI

struct EventCardButton<Background: ShapeStyle>: View {
    
    let imageName: String
    let background: Background
    let action: () -> Void

    var body: some View {
        EventCardVStack {
            CircleButton(imageName: imageName, background: background) {
                action()
            }
        }
    }

}
