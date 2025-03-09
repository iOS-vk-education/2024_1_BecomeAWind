import SwiftUI

struct C: View {

    enum Field {
        case title, seats, link
    }

    @State private var title = ""
    @State private var seats = ""
    @State private var link = ""


    @FocusState private var focus: Field?


    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                TextField("Enter your first name", text: $title)
                    .focused($focus, equals: .title)

                TextField("Enter your last name", text: $seats)
                    .focused($focus, equals: .seats)

                TextField("Enter your email address", text: $link)
                    .focused($focus, equals: .link)
            }
//            .background(Colors.black)

            VStack {
                Spacer()
                YCircleButton(imageName: "arrowtriangle.down") {
                    focus = nil
                }
            }
            .padding(.bottom, Const.sideSpace)
            .opacity(focus == nil ? 0 : 1)
        }
    }

}

#Preview {
    C()
}

