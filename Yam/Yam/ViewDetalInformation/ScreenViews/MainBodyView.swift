//
//  MainBodyView.swift
//  Yam
//
//  Created by Ширапов Арсалан on 18.12.2024.
//

import SwiftUI

struct MainBodyView: View {
    var body: some View {
        SwipeEventsView()
    }
}

struct Event: Identifiable {
    let id = UUID()
    let view: AnyView
}

struct SwipeEventsView: View {
    let events: [Event] = [
        Event(view: AnyView(
            ZStack(alignment: .bottomLeading) {
                ViewCardFirst()
            }
        )),
        Event(view: AnyView(
            ZStack(alignment: .bottomLeading) {
                ViewCardSecond()
            }
        )),
        Event(view: AnyView(
            ZStack(alignment: .bottomLeading) {
                ViewCardThird()
            }
        )),
        Event(view: AnyView(
            ZStack(alignment: .bottomLeading) {
                ViewCardFirst()
            }
        )),
        Event(view: AnyView(
            ZStack(alignment: .bottomLeading) {
                ViewCardSecond()
            }
        )),
        Event(view: AnyView(
            ZStack(alignment: .bottomLeading) {
                ViewCardThird()
            }
        ))
    ]
    
    var body: some View {
        TabView {
            ForEach(events) { event in
                event.view
            }
        }
        .tabViewStyle(.page)
        .frame(height: 650)
        .cornerRadius(30)
        Spacer()
    }
}

#Preview {
    MainBodyView()
}
