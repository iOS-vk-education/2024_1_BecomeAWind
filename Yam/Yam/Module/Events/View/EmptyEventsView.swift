import SwiftUI

struct EmptyEventsView: View {

    let text: String

    var body: some View {
        Text(text)
            .fixedSizeText(background: .thinMaterial)
    }

}
