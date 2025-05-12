import SwiftUI

struct TextFieldView: View {

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

        YTextField(text: text, prompt: prompt, lineLimit: lineLimit, axis: axis)
    }

}

#Preview {
    @Previewable @State var text = ""
    TextFieldView(
        text: $text,
        title: "текст",
        lineLimit: 3,
        axis: .vertical
    )
}
