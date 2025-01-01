//
//  EntryEvent.swift
//  Yam
//
//  Created by Ширапов Арсалан on 16.11.2024.
//

import SwiftUI

struct EntryEvent: View {
    var body: some View {
        VStack{
            Heading()
            Events()
        }
        .background(Color(UIColor(named: "ViewDetalBlack")!))
    }
}
