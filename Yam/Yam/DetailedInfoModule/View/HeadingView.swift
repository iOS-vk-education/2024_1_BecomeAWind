import SwiftUI

struct Heading: View {
    var body: some View {
        HStack {
            Spacer()
            Header()
            Spacer()
//            BackButton()
        }
        .padding()
    }
}

struct Header: View {
    var body: some View {
        Text("События")
            .frame(alignment: .center)
            .font(.largeTitle)
            .colorInvert()
    }
}

struct BackButton: View {
    var body: some View {
        Button(
            action: {

            },
            label: {
                Image(systemName: "x.circle.fill")
                    .accentColor(Color.gray)

            }
        )
    }
}
