import SwiftUI

struct CreateEventTextField: View {
    var text: Binding<String>
    let title: String
    let prompt: String
    let lineLimit: Int

    init(text: Binding<String>, title: String, prompt: String = "Введите текст", lineLimit: Int) {
        self.text = text
        self.title = title
        self.prompt = prompt
        self.lineLimit = lineLimit
    }

    var body: some View {
        HStack {
            Spacer()

            VStack(alignment: .leading) {
                YamText(text: title)

                TextField(
                    "",
                    text: text,
                    prompt:
                        Text(prompt)
                        .foregroundColor(ColorsPack.white2),
                    axis: .vertical
                )
                .background(ColorsPack.gray)
                .tint(ColorsPack.purple)
                .foregroundColor(ColorsPack.white)
                .lineLimit(lineLimit)
            }

            Spacer()
        }
    }
}

// #Preview {
//    @Previewable @State var title = ""
//    CreateEventTextField(text: $title, title: "Текст", lineLimit: 3)
// }
