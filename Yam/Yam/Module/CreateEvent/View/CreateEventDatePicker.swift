import SwiftUI

struct CreateEventDatePicker: View {
    var date: Binding<Date>
    var timeZone: Binding<TimeZone>

    var body: some View {
        VStack {
            HStack {
                Spacer()
                    .foregroundColor(ColorPack.white)
                DatePicker(selection: date, displayedComponents: [.date, .hourAndMinute]) {}
                .tint(ColorPack.purple)
                .colorScheme(.dark)
                .background(ColorPack.gray)
                Spacer()
            }
            HStack {
                Spacer()
                Picker(selection: timeZone, label: EmptyView()) {
                    ForEach(TimeZone.knownTimeZoneIdentifiers, id: \.self) { identifier in
                        if let timeZone = TimeZone(identifier: identifier) {
                            Text(timeZone.localizedName(for: .standard, locale: Locales.ru) ?? identifier)
                                .tag(timeZone)
                        }

                    }
                }
                .pickerStyle(.menu)
                .tint(ColorPack.purple)
                .foregroundColor(ColorPack.white)
                .colorScheme(.dark)
                Spacer()
            }

        }

    }
}

// #Preview {
//    @Previewable @State var date = Date()
//    CreateEventDatePicker(date: $date)
// }
