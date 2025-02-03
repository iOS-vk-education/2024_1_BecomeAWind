import SwiftUI

struct CreateEventDatePicker: View {
    var date: Binding<Date>
    var timeZone: Binding<TimeZone>

    var body: some View {
        VStack {
            YamWhiteText(text: "когда")

            DatePicker(selection: date, displayedComponents: [.date, .hourAndMinute]) {
                YamWhiteText(text: "дата и время")
            }
            .pickerStyle(.menu)
            .tint(ColorPack.purple)
            .foregroundColor(ColorPack.white)
            .colorScheme(.dark)
            .padding(.bottom)

            HStack {
                YamWhiteText(text: "часовой пояс")

                Picker(selection: timeZone, label: EmptyView()) {
                    ForEach(TimeZone.knownTimeZoneIdentifiers, id: \.self) { identifier in
                        if let timeZone = TimeZone(identifier: identifier) {
                            Text(timeZone.localizedName(for: .standard, locale: Locales.ru) ?? identifier)
                                .tag(timeZone)
                        }

                    }
                }
                .padding(.leading)
                .padding(.vertical)
            }
        }

        .tint(ColorPack.purple)
        .colorScheme(.dark)
        .padding(.horizontal)
        .padding(.bottom)
    }
}

#Preview {
    @Previewable @State var date = Date()
    @Previewable @State var tz = TimeZone.current
    CreateEventDatePicker(date: $date, timeZone: $tz)
        .background(ColorPack.black)
}
