import SwiftUI

struct CreateEventDatePicker: View {
    var date: Binding<Date>

    var body: some View {
        HStack {
            Spacer()
                .foregroundColor(ColorsPack.white)
            DatePicker(selection: date, displayedComponents: [.date, .hourAndMinute]) {}
            .tint(ColorsPack.purple)
            .colorScheme(.dark)
            .background(ColorsPack.gray)
            Spacer()
        }
    }
}

#Preview {
    @Previewable @State var date = Date()
    CreateEventDatePicker(date: $date)
}
