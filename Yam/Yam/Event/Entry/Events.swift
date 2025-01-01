//
//  Events.swift
//  Yam
//
//  Created by Ширапов Арсалан on 18.12.2024.
//

import SwiftUI

struct Events: View {
    var body: some View {
        TabEvent()
        Spacer()
    }
}

struct TabEvent: View {
    @StateObject private var viewModel = EventViewModel()

    var body: some View {
        TabView {
            ForEach(viewModel.events) { event in
                EventCard(event: event)
            }
        }
        .tabViewStyle(.page)
        .cornerRadius(30)
    }
}

#Preview {
    Events()
}
