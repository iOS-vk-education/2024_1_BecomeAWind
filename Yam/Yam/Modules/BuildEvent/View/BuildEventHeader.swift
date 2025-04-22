import SwiftUI

struct BuildEventHeader: View {

    let text: String

    var body: some View {
        YText(text, font: Const.headerTextFont)
    }
    
}

#Preview {
    BuildEventHeader(text: "text")
}
