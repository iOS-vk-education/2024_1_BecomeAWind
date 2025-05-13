import SwiftUI

struct YTextField: View {

    var text: Binding<String>
    let prompt: String
    let lineLimit: Int
    let axis: Axis

    var body: some View {
        VStack {
            TextField(
                "",
                text: text,
                prompt:
                    Text(prompt)
                    .font(Const.sectionEmptyFont)
                    .foregroundColor(Colors.white2),
                axis: axis
            )
            .padding()
            .autocorrectionDisabled()
            .autocapitalization(.none)
            .lineLimit(lineLimit)
            .tint(.purple)
            .foregroundColor(.white)
            .font(Const.placeDescriptionFont)
        }
        .background(.thinMaterial)
        .cornerRadius(Const.cornerRadius)
        .padding(.horizontal)
        .padding(.bottom)
    }

}
