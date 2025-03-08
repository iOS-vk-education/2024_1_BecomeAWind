import SwiftUI

struct CreateEventTextField: View {
    var text: Binding<String>
    let title: String
    let prompt: String
    let lineLimit: Int

    init(text: Binding<String>, title: String, prompt: String = "введи текст", lineLimit: Int) {
        self.text = text
        self.title = title
        self.prompt = prompt
        self.lineLimit = lineLimit
    }

    var body: some View {
//        YamText(title)

        CreateEventVStack {
            TextField(
                "",
                text: text,
                prompt:
                    Text(prompt)
//                    .font(FontManager.getFont(with: .regular,
//                                              and: SizePack.textFieldFontSize))
                    .foregroundColor(Colors.white2),
                axis: .vertical
            )
            .padding()
            .tint(Colors.purple)
            .foregroundColor(Colors.white)
            .lineLimit(lineLimit)
//            .font(FontManager.getFont(with: .medium,
//                                      and: SizePack.textFieldFontSize))
            .keyboardType(.asciiCapable)
            .autocorrectionDisabled()
        }
    }
}

 #Preview {
    @Previewable @State var title = ""
    CreateEventTextField(text: $title, title: "текст", lineLimit: 3)
 }
