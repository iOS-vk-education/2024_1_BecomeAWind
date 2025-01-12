//
//  EventCard.swift
//  Yam
//
//  Created by Ширапов Арсалан on 01.01.2025.
//

import SwiftUI

struct EventCard: View {
    @State var event: Event

    var body: some View {
        VStack(alignment: .leading) {
            HeaderEvent(info: event.description)
            EventDescriptionView(descriprion: event.description.description)
            Spacer()
            ContentEventView(event: event)
        }
        .frame(width: .infinity, height: .infinity)
        .background(Color("ViewDetalGray"))
        .cornerRadius(30)
        .shadow(radius: 5)
    }
}

struct HeaderEvent: View {
    @State var info: EventDescription

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            EventImage(imageName: info.imageName)
            EventTitle(title: info.title)
        }
    }
}

struct ContentEventView: View {
    @State var event: Event

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ContentItemEvent(title: "Категория:", data: event.description.category.rawValue)
            ContentItemEvent(title: "Количество свободных мест:", data: String(event.organization.freePlaces))
            ContentItemEvent(title: "Место проведения:", data: event.organization.place)
            ContentItemEvent(title: "Ссылка на организатора:", data: event.organization.link)
        }
        .padding()
        .padding(.bottom, 40)
        .background(Color("ViewDetalGray"))
        .cornerRadius(10)
    }
}

