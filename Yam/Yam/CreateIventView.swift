import SwiftUI
import Combine

struct CreateIventView: View {
    
    @State private var date = Date()
    
    var body: some View {
        ZStack{
            Color.darkBackground1.edgesIgnoringSafeArea(.all)
            ScrollView{
                VStack {
                    AddPhoto()
                    NewTextField(name: "Название", maxLength: 15, width: 324, height: 48, color: .white)
                    SelectorCategories()
                    ZStack{
                        
                        Rectangle()
                            .frame(width: 324, height: 48)
                            .foregroundStyle(.darkBackground2)
                            .cornerRadius(30)
                        
                        DatePicker("Дата", selection: $date)
                            .font(.system(size: 22))
                            .bold()
                            .frame(width: 295, height: 40)
                            .cornerRadius(30)
                            .colorScheme(.dark)
                            .padding(.vertical, 11)
                    }
                    
                    HStack{
                        
                        ZStack{
                            Rectangle()
                                .frame(width: 263, height: 50)
                                .foregroundStyle(.darkBackground2)
                                .cornerRadius(30)
                            
                            Text("Местоположение")
                                .font(.system(size: 22))
                                .bold()
                                .foregroundColor(.white)
                                .frame(width: 263, alignment: .leading)
                                .padding(.vertical, 11)
                                .offset(x: 15, y: 0)
                        }
                        
                        Button{
                            //
                        } label: {
                            Image(systemName: "map")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.white)
                        }
                    }
                    .frame(width: 324, height: 50)
                    
                    NewTextEditor(name: "Описание", maxLength: 200, width: 324, height: 114, color: .white)
                   
                    NewTextField(name: "https/", maxLength: 40, width: 324, height: 48, color: .salatGreen)
                    
                    Button{
                        //
                    } label: {
                        Text("Создать")
                            .font(.system(size: 22))
                            .bold()
                            .frame(width: 324, height: 48)
                            .foregroundColor(.white)
                            .overlay(RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.white, lineWidth: 1)
                                .foregroundColor(.darkBackground1))
                            
                    }
                }
            }
            .frame(width: .infinity)        }
    }
}

#Preview {
    CreateIventView()
}
