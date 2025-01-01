//
//  ViewCardFirst.swift
//  Yam
//
//  Created by Ширапов Арсалан on 18.12.2024.
//

import SwiftUI

struct ViewCardFirst: View {
    var body: some View {
        VStack(alignment: .leading) {
            Image("basketball")
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .clipped()
                .cornerRadius(30, corners: [.topLeft, .topRight])
            
            Text("Баскетбол")
                .font(.system(size: 30))
                .bold()
                .foregroundColor(.white)
                .padding(.horizontal)
            
            Text("""
            Нужен 1+ человек на игру в “33”, хотите поиграть, но не знаете правила - объясню, только скорее приходите, мне очень скучно
            """)
                .font(.body)
                .foregroundColor(.white)
                .padding(.horizontal)
            Spacer()
                 
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Категория:")
                        .foregroundColor(.white)
                    Spacer()
                    
                    Text("Спортивные игры")
                        .foregroundColor(.green)
                    }
                        
                    HStack {
                        Text("Количество свободных мест:")
                            .foregroundColor(.white)
                        Spacer()
                        Text("7")
                            .foregroundColor(.green)
                    }
                        
                    HStack {
                        Text("Место проведения:")
                            .foregroundColor(.white)
                        Spacer()
                        Text("Ул. России 17")
                            .foregroundColor(.green)
                    }
                        
                    HStack {
                        Text("Ссылка на организатора:")
                            .foregroundColor(.white)
                            .frame(width: .infinity)
                        Spacer()
                        Link("ССЫЛКА НА ТГ", destination: URL(string: "https://t.me/bobs")!)
                                .foregroundColor(.blue)
                    }
            }
            .padding()
            .padding(.bottom, 40)
            .background(Color("ViewDetalGray"))
            .cornerRadius(10)
                
            }
            .frame(width: 350, height: 650)
            .background(Color("ViewDetalGray"))
            .cornerRadius(30)
            .shadow(radius: 5)
        }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    ViewCardFirst()
}
