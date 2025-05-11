import SwiftUI

struct YTextField: View {

    var text: Binding<String>
    let title: String
    let prompt: String
    let lineLimit: Int
    let axis: Axis

    init(
        text: Binding<String>,
        title: String,
        prompt: String = "введи текст",
        lineLimit: Int,
        axis: Axis
    ) {
        self.text = text
        self.title = title
        self.prompt = prompt
        self.lineLimit = lineLimit
        self.axis = axis
    }

    var body: some View {
        YText(title, font: Const.sectionTitleFont)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading)

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
        .background(Colors.gray)
        .cornerRadius(Const.cornerRadius)
        .padding(.horizontal)
        .padding(.bottom)
    }

}

#Preview {
    @Previewable @State var text = ""
    YTextField(
        text: $text,
        title: "текст",
        lineLimit: 3,
        axis: .vertical
    )
}
