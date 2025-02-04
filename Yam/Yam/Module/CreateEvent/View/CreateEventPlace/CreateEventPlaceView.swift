import SwiftUI
import MapKit

struct CreateEventPlaceView: View {
    @ObservedObject var viewModel: CreateEventViewModel
    @State var centerCoordinate = CLLocationCoordinate2D()
    @Binding var isActiveCreateEventPlaceView: Bool

    var body: some View {
        ZStack {
            ZStack(alignment: .bottom) {
                // map
                CreateEventPlaceMap(centerCoordinate: $centerCoordinate)
                    .ignoresSafeArea()

                // choose button
                Button {
//                    viewModel.getPlacemark(for: centerCoordinate) { placemark in
//                        if let placemark {
//                            let place = PlaceModel(placemark: placemark,
//                                                   coordinate: centerCoordinate)
//                            viewModel.handlePlace(place)
//                            isActiveCreateEventPlaceView.toggle()
//                        }
//                    }
                } label: {
                    YamCapsuleLabel(title: "выбрать")
                }
            }

            // mappin
            YamMappin()
        }
    }
}

 #Preview {
    @Previewable @State var bool = true
     CreateEventPlaceView(viewModel: CreateEventViewModel(model: CreateEventModel()),
                          isActiveCreateEventPlaceView: $bool)
 }
