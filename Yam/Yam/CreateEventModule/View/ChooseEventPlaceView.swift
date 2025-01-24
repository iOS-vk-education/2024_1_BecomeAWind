import SwiftUI
import MapKit

struct ChooseEventPlaceView: View {
    @ObservedObject var viewModel: CreateEventViewModel
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @Binding var isActiveChooseEventPlaceView: Bool

    var body: some View {
        ZStack {
            ZStack(alignment: .bottom) {
                ChooseEventPlaceMapViewModel(centerCoordinate: $centerCoordinate)
                    .ignoresSafeArea()

                Button {
                    ChooseEventPlaceMapViewModel.getPlacemark(for: centerCoordinate) { placemark in
                        if let placemark {
                            let place = Place(placemark: placemark,
                                              coordinate: centerCoordinate)
                            viewModel.handlePlace(place)
                            isActiveChooseEventPlaceView.toggle()
                        }
                    }
                } label: {
                    GradientLabel(title: "Выбрать",
                                  background: GradientsPack.indigoPurple)
                }
                .padding(.bottom, 10)
            }

            GradientImage(imageName: "mappin.circle",
                          imageSize: CreateEventViewSizesPack.imageSize,
                          background: GradientsPack.indigoPurple)
        }
    }
}

//#Preview {
//    @Previewable @State var bool = true
//    ChooseEventPlaceView(viewModel: CreateEventViewModel(model: CreateEventModel()), isActiveChooseEventPlaceView: $bool)
//}
