import SwiftUI

struct MakeEventHeader: View {

    let text: String

    var body: some View {
        YText(text, font: Const.headerTextFont)
    }
    
}

#Preview {
    MakeEventHeader(text: "text")
}
