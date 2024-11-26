import SwiftUI

struct SelectorCategories: View {
    
    @State var selectedOption: String = "Категория:"
    let options = ["Развлечение", "Спорт", "Образование", "Путешествие", "Еда", "Исскуство"]
    
    var body: some View {
        HStack{
            Menu{
                ForEach(options, id: \.self) { option in
                    Button(action: {selectedOption = option} ) {
                        Text(option)
                    }
                }
            } label: {
                ZStack{
                    Rectangle()
                        .frame(width: 324, height: 48)
                        .foregroundStyle(.darkBackground2)
                        .cornerRadius(30)
                    Text(selectedOption)
                        .frame(width: 295, alignment: .leading)
                        .bold()
                        .font(.system(size: 22))
                        .foregroundColor(.white)
                        .padding(.vertical, 15)
                }
            }
            .frame(width: 324, height: 48)
        }
    }
}
