//
//  ViewCardSecond.swift
//  Yam
//
//  Created by Ширапов Арсалан on 19.12.2024.
//

import SwiftUI

struct ViewCardSecond: View {
    var body: some View {
        VStack(alignment: .leading) {
<<<<<<< HEAD
            
            ZStack(alignment: .bottomLeading) {
                Image("football")
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
                
                Text("Футбол")
                    .font(.system(size: 30))
                    .bold()
                    .foregroundColor(.white)
                    .padding()
            }
=======
        
            Image("football")
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .clipped()
                .cornerRadius(30, corners: [.topLeft, .topRight])
            
            Text("Футбол")
                .font(.system(size: 30))
                .bold()
                .foregroundColor(.white)
                .padding(.horizontal)
                
>>>>>>> f092466 (View Detail Inf Screen Done)
            Text("""
                Привет! Сегодня в 18:00 мы с друзьями хотим провести дружеский матч, но нас не так много. Нужно 7 человек. Желающие поиграть, повеселиться и обрести новые знакомства, мы вас ждем зажидаемся!! 
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
                    Spacer()
<<<<<<< HEAD
                    Link("ССЫЛКА НА ТГ", destination: URL(string: "https://t.me/bobs")!)
=======
                    Link("t.me/bobs", destination: URL(string: "https://t.me/bobs")!)
>>>>>>> f092466 (View Detail Inf Screen Done)
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
    ViewCardSecond()
}
