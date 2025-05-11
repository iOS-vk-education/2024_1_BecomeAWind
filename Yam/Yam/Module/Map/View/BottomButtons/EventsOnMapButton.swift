import SwiftUI

struct EventsOnMapButton: View {

    @ObservedObject var viewModel: MapViewModel
    let action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            Text(viewModel.getEventsCount())
                .font(MapConst.clusterCountFont)
                .frame(width: Const.screenWidth * 0.2,
                       height: Const.screenWidth * 0.2)
                .background(Gradient.purpleIndigo)
                .foregroundColor(.white)
                .clipShape(
                    RoundedRectangle(cornerRadius: Const.cornerRadius)
                )
        }
    }
}

#Preview {
    EventsOnMapButton(viewModel: MapViewModel(navManager: NavigationManager()), action: {})
}
