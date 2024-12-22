//
//  HeadingView.swift
//  Yam
//
//  Created by Ширапов Арсалан on 18.12.2024.
//

import SwiftUI

struct HeadingView: View {
    var body: some View {
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> f092466 (View Detail Inf Screen Done)
        Heading()
    }
}

struct Heading: View {
    var body: some View {
        HStack {
            Spacer()
            title()
            Spacer()
            backButton()
        }
        .padding()
    }
}

struct title: View {
    var body: some View {
        Text("События")
            .frame(alignment: .center)
            .font(.largeTitle)
            .colorInvert()
    }
}
struct backButton: View {
    var body: some View {
        Button(
            action:{},
            label:{
                Image(systemName: "x.circle.fill")
                    .accentColor(Color.gray)
                
            }
        )
<<<<<<< HEAD
=======
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
>>>>>>> a060c68 (обновил версию ios)
=======
>>>>>>> f092466 (View Detail Inf Screen Done)
    }
}

#Preview {
    HeadingView()
}
