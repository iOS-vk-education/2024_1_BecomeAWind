import SwiftUI

struct IndigoPurpleButtonLabel: View {
    var title: String

    var body: some View {
        Text(title)
            .padding()
            .fontWeight(.heavy)
            .foregroundColor(Colors.white)
            .background(Gradients.indigoPurple)
            .cornerRadius(Sizes.coreCornerRadius)

    }
}

#Preview {
    IndigoPurpleButtonLabel(title: "OPEN SETTINGS")
}
