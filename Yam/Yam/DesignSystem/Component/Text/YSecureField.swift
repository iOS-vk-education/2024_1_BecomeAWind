import SwiftUI

struct YSecureField: View {

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
        YText(title, font: Const.sectionTitleFont)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, Const.sideSpace)

        VStack {
            SecureField(
                "",
                text: text,
                prompt:
                    Text(prompt)
                    .font(Const.sectionEmptyFont)
                    .foregroundColor(Colors.white2)
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
        .padding(.horizontal, Const.sideSpace)
        .padding(.bottom)
    }

}

//#Preview {
//    @Previewable @State var text = ""
//    YTextField(
//        text: $text,
//        title: "текст",
//        lineLimit: 3
//    )
//}
