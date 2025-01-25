import SwiftUI

struct CreateEventDatePicker: View {
    var date: Binding<Date>
    var timeZone: Binding<TimeZone>

    var body: some View {
        VStack {
            HStack {
                Spacer()
                    .foregroundColor(ColorsPack.white)
                DatePicker(selection: date, displayedComponents: [.date, .hourAndMinute]) {}
                .tint(ColorsPack.purple)
                .colorScheme(.dark)
                .background(ColorsPack.gray)
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
                .tint(ColorsPack.purple)
                .foregroundColor(ColorsPack.white)
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
