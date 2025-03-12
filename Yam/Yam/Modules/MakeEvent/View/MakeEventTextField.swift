import SwiftUI

struct MakeEventTextField: View {

    var text: Binding<String>
    let title: String
    let prompt: String
    let lineLimit: Int

    init(
        text: Binding<String>,
        title: String,
        prompt: String = "введи текст",
        lineLimit: Int
    ) {
        self.text = text
        self.title = title
        self.prompt = prompt
        self.lineLimit = lineLimit
    }

    var body: some View {
        YText(title, font: MakeEventConst.sectionTitleFont)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, Const.sideSpace)

        MakeEventVStack {
            TextField(
                "",
                text: text,
                prompt:
                    Text(prompt)
                    .font(MakeEventConst.sectionEmptyFont)
                    .foregroundColor(Colors.white2),
                axis: .vertical
            )
            .padding()
            .autocorrectionDisabled()
            .autocapitalization(.none)
            .lineLimit(lineLimit)
            .tint(Colors.purple)
            .foregroundColor(Colors.white)
            .font(Const.placeDescriptionFont)
        }
    }

}

#Preview {
    @Previewable @State var text = ""
    MakeEventTextField(
        text: $text,
        title: "текст",
        lineLimit: 3
    )
}
