import SwiftUI
import Combine

struct NewTextEditor: View {
    
    let name: String
    let maxLength: Int
    let width: CGFloat
    let height: CGFloat
    let color: Color
    
    @State private var title = ""
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            Rectangle()
                .frame(width: width, height: height)
                .cornerRadius(30)
                .foregroundColor(.darkBackground2)
            
            TextEditor(text: $title)
                .scrollContentBackground(.hidden)
                .onReceive(Just(title)) { newValue in
                    if newValue.count > maxLength {
                        self.title = String(newValue.prefix(maxLength))
                    }}
                .frame(width: 295, alignment: .leading)
                .frame(height: height, alignment: .top)
                .foregroundColor(.white)
                .bold()
                .font(.system(size: 22))
                .padding(.vertical, 15)
                .offset(x: 15, y: 0)
            
            if title.isEmpty {
                Text(name)
                    .frame(width: 285, alignment: .leading)
                    .frame(height: 100, alignment: .top)
                    .font(.system(size: 22))
                    .bold()
                    .foregroundColor(.unknownText)
                    .padding(.horizontal, 18)
            }
            
        }
        .frame(width: width, height: height)
    }
}
