import SwiftUI
import MapKit

struct ChooseEventPlaceView: View {
    @ObservedObject var viewModel: CreateEventViewModel
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @Binding var isActiveChooseEventPlaceView: Bool

    var body: some View {
        ZStack {
            ZStack(alignment: .bottom) {
                ChooseEventPlaceViewModel(centerCoordinate: $centerCoordinate)
                    .ignoresSafeArea()

                Button {
                    ChooseEventPlaceViewModel.getPlacemark(for: centerCoordinate) { placemark in
                        if let placemark {
                            let place = PlaceModel(placemark: placemark,
                                              coordinate: centerCoordinate)
                            viewModel.placeDescription = PlaceHandler.handlePlace(place)
                            viewModel.place = place
                            isActiveChooseEventPlaceView.toggle()
                        }
                    }
                } label: {
                    YamCapsuleLabel(title: "выбрать")
                }
                .padding(.bottom, 10)
            }

            GradientImage(imageName: "mappin.circle",
                          imageSize: SizePack.smallImageSize,
                          background: GradientPack.purpleIndigo)
        }
    }
}

// #Preview {
//    @Previewable @State var bool = true
//    ChooseEventPlaceView(viewModel: CreateEventViewModel(model: CreateEventModel()), isActiveChooseEventPlaceView: $bool)
// }
