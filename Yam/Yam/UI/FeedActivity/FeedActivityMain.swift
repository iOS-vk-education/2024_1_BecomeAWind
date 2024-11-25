//
//  FeedActivityMain.swift
//  Yam
//
//  Created by Mac on 26.11.2024.
//

import SwiftUI

struct FeedActivityMain: View {
    let color = UIColor(named: "MainColor")
    var body: some View {
        ZStack {
            Color("MainColor")
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    FeedMainButton()
                    FeedCardFirst()
                    FeedCardSecond()
                    FeedCardThird()
                    Spacer()
                }
            }
        }
    }
}

    struct FeedActivityMain_Previews: PreviewProvider {
        static var previews: some View {
            FeedActivityMain()
        }
}
