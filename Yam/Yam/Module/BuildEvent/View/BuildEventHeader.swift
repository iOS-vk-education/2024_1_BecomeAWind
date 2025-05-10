import SwiftUI

struct BuildEventHeader: View {

    let text: String

    var body: some View {
        YText(text, font: Const.headerTextFont)
            .padding(.top)
    }
    
}

#Preview {
    BuildEventHeader(text: "text")
}
