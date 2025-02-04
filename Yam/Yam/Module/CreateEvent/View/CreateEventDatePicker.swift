import SwiftUI

struct CreateEventDatePicker: View {
    var date: Binding<Date>
    var timeZone: Binding<TimeZone>

    var body: some View {
        YamWhiteText(text: "когда")

        CreateEventVStack {
            DatePicker(selection: date, displayedComponents: [.date, .hourAndMinute]) {}
            .environment(\.locale, Locales.ru)
            .datePickerStyle(.graphical)
            .tint(ColorPack.purple)
            .colorScheme(.dark)
            .padding(.horizontal)
            .padding(.bottom)

            Picker(selection: timeZone, label: EmptyView()) {
                ForEach(TimeZone.knownTimeZoneIdentifiers, id: \.self) { identifier in
                    if let timeZone = TimeZone(identifier: identifier) {
                        Text(timeZone.localizedName(for: .standard, locale: Locales.ru) ?? identifier)
                            .tag(timeZone)
                    }
                }
            }
            .tint(ColorPack.purple)
            .colorScheme(.dark)
            .padding(.bottom)
        }
    }
}

#Preview {
    @Previewable @State var date = Date()
    @Previewable @State var tz = TimeZone.current
    CreateEventDatePicker(date: $date, timeZone: $tz)
}
