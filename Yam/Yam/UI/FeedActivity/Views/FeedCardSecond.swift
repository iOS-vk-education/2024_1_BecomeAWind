//
//  FeedCardSecond.swift
//  Yam
//
//  Created by Mac on 26.11.2024.
//

import SwiftUI

struct FeedCardSecond: View {
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                headImage
                VStack(alignment: .leading) {
                    headButton
                    HStack {
                        dataTime
                        buttonToMap
                    }

                }
                .padding(24)
            }
            .padding(.top, 10)
        }

    }
    var headButton: some View {
        Button(
            action: {},
            label: {
                Text("Футбол")
                    .modifier(HeadButtonModifier())

            }
        )
    }
    var dataTime: some View {
        Text("23.11.2024 | 17:00")
            .modifier(DataTimeModifier())
    }

    var headImage: some View {
        Image("football")
            .resizable()
            .mask(LinearGradient(
                gradient: Gradient(colors: [Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.9), Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)).opacity(0.1)]),
                startPoint: .top, endPoint: .bottom))

            .frame(width: 324, height: 257)
            .aspectRatio(contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 30))

    }
    var buttonToMap: some View {
        Button(
            action: {},
            label: {
                Text("Показать на карте")
                    .modifier(ButtonToModifier())

            }
        )

    }
    struct HeadButtonModifier: ViewModifier {
        func body(content: Content) -> some View {
            content
                .font(.system(size: 24))
                .fontWeight(.light)
                .foregroundColor(Color.white)
                .underline()
        }
    }
    struct DataTimeModifier: ViewModifier {
        func body(content: Content) -> some View {
            content
                .padding(4)
                .frame(width: 118, height: 31)
                .background(Color("LabelColor").opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .shadow(color: Color.black.opacity(0.2), radius: 3)
                .foregroundColor(Color.white)
                .fontWeight(.regular)
                .font(.system(size: 10))
        }
    }

    struct ButtonToModifier: ViewModifier {
        func body(content: Content) -> some View {
            content
                .padding(4)
                .frame(width: 169, height: 31)
                .background(Color("LabelColor").opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .shadow(color: Color.black.opacity(0.2), radius: 3)
                .foregroundColor(Color.white)
                .fontWeight(.regular)
                .font(.system(size: 10))
        }
    }

}

struct FeedCardSecond_Previews: PreviewProvider {
    static var previews: some View {
        FeedCardSecond()
    }
}
