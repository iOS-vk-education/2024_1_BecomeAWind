import SwiftUI

struct EventsCountView: View {

    let countString: String

    var body: some View {
        Text(countString)
            .font(Const.eventsCountFont)
            .frame(minWidth: Const.screenWidth * 0.17,
                   maxHeight: Const.screenWidth * 0.17)
            .background(.thinMaterial)
            .clipShape(
                RoundedRectangle(cornerRadius: Const.cornerRadius)
            )
    }

}

#Preview {
    EventsCountView(countString: "99+")
}
