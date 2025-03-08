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
                }

                Section {
                    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) { // По центру
//                    YamText("ивенты",
//                            fontSize: 30
//                    )
                }

                ToolbarItem {
                    Button {

                    } label: {
                        HStack {
//                            YamText("",
//                                    fontWeight: .regular,
//                                    fontSize: 17,
//                                    foregroundColor: ColorPack.purple)
                            Image(systemName: "plus.circle")
                        }
                    }
                    .foregroundColor(Colors.purple)
                }
            }
        }


    }
}

#Preview {
    Delme()
    //        .background(.white)
}
