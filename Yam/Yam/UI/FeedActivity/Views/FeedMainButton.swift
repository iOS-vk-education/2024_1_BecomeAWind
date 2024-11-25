//
//  FeedMainButton.swift
//  Yam
//
//  Created by Mac on 26.11.2024.
//

import SwiftUI

struct FeedMainButton: View {
    var body: some View {
        VStack {
            textLent
            HStack {
                buttonSort
                buttonFiltr
            }
        }
    }
    var buttonFiltr: some View {
        Button(
            action: {},
            label: {
                Text("Фильтрация")
                    .modifier(ButtonFiltrModifier())

            }
        )
    }
    var buttonSort: some View {
        Button(
            action: {},
            label: {
                Text("Cортировка")
                    .modifier(ButtonSortModifier())

            }
        )
    }
    var textLent: some View {
        Text("Лента активностей")
            .modifier(TextLentModifier())
    }
    struct ButtonFiltrModifier: ViewModifier {
        func body(content: Content) -> some View {
            content
                .padding(4)
                .frame(width: 170, height: 31)
                .background(Color("ButtonColor"))
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .shadow(color: Color.black.opacity(0.2), radius: 3)
                .foregroundColor(Color.white)
                .fontWeight(.bold)
                .font(.system(size: 16))
        }
    }
    struct ButtonSortModifier: ViewModifier {
        func body(content: Content) -> some View {
            content
                .padding(4)
                .frame(width: 170, height: 31)
                .background(Color("ButtonColor"))
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .shadow(color: Color.black.opacity(0.2), radius: 3)
                .foregroundColor(Color.white)
                .fontWeight(.bold)
                .font(.system(size: 16))
        }
    }
    struct TextLentModifier: ViewModifier {
        func body(content: Content) -> some View {
            content
                .foregroundColor(Color.white)
                .fontWeight(.bold)
                .font(.system(size: 20))
        }
    }

}

struct FeedMainButton_Previews: PreviewProvider {
    static var previews: some View {
        FeedMainButton()
    }
}
