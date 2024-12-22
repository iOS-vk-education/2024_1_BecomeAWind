//
//  ViewDetalInf.swift
//  Yam
//
//  Created by Ширапов Арсалан on 16.11.2024.
//

import SwiftUI

struct ViewDetalInf: PreviewProvider {
    static var previews: some View {
        allScreen()
    }
}

struct allScreen:View {
    var body: some View {
        VStack{
            Heading()
            MainBodyView()
        }
        .background(Color(UIColor(named: "ViewDetalBlack")!))
    }
}
