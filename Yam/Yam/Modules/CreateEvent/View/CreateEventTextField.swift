import SwiftUI

struct CreateEventTextField: View {

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
        HStack {
            YText(title, font: CreateEventFont.sectionTitleFont)
            Spacer()
        }
        .padding(.leading, Const.sideSpace)

        CreateEventVStack {
            TextField(
                "",
                text: text,
                prompt:
                    Text(prompt)
                    .font(CreateEventFont.sectionContentFont)
                    .foregroundColor(Colors.white2),
                axis: .vertical
            )
            .padding()
            .autocorrectionDisabled()
            .lineLimit(lineLimit)
            .tint(Colors.purple)
            .foregroundColor(Colors.white)
            .font(CreateEventFont.sectionContentFont)

        }
    }

}

 #Preview {
    @Previewable @State var text = ""
    CreateEventTextField(
        text: $text,
        title: "текст",
        lineLimit: 3
    )
 }
