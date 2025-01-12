//
//  ViewModel.swift
//  Yam
//
//  Created by Ширапов Арсалан on 01.01.2025.
//

import SwiftUI

final class EventViewModel: ObservableObject {
    private var mockData = EventsMock()

    @Published var events: [Event] = []

    init() {
        getEvents()
    }

    func getEvents() {
        events = mockData.getEvents()
    }
}
