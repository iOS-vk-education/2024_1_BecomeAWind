//
//  Delme.swift
//  Yam
//
//  Created by Satin on 12.02.2025.
//

import SwiftUI

struct Delme: View {
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                }

                Section {
                    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                }
            }
//            .navigationTitle("ивенты")
//            .font(FontManager.getFont(with: .bold, and: 20))
            .toolbar {
                ToolbarItem {
                    Button {

                    } label: {
                        HStack {
                            YamText("новый ивент",
                                    fontWeight: .regular,
                                    fontSize: 17,
                                    foregroundColor: ColorPack.purple)
                            Image(systemName: "plus.circle")
                        }
                    }
                    .foregroundColor(ColorPack.purple)
                }
            }
        }

        .foregroundColor(.white)
//        .colorScheme(.dark)

    }
}

#Preview {
    Delme()
//        .background(.white)
}
