//
//  ViewCardThird.swift
//  Yam
//
//  Created by Ширапов Арсалан on 19.12.2024.
//

import SwiftUI

struct ViewCardThird: View {
    var body: some View {
        VStack(alignment: .leading) {
            
            ZStack(alignment: .bottomLeading) {
                Image("projectX")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .clipped()
                    .cornerRadius(30, corners: [.topLeft, .topRight])
                    .overlay(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.6)]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                
                Text("Тусовка по репосту")
                    .font(.system(size: 30))
                    .bold()
                    .foregroundColor(.white)
                    .padding()
            }
            
            Text("""
            Приходите на мега тусу джусу сегодня в 18:00!!! Для доп. вопросов пишите в телегу, ссылка внизу
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
                    Text("Развлечения")
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

#Preview {
    ViewCardThird()
}
