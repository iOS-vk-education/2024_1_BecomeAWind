import SwiftUI
import MapKit

struct CreateEventPlaceView: View {

    @ObservedObject var viewModel: CreateEventViewModel
    @Environment(\.dismiss) private var dismiss
    @State var centerCoordinate = CLLocationCoordinate2D()

    var body: some View {
        ZStack {
            ZStack(alignment: .bottom) {
                /// map
                CreateEventPlaceMap(centerCoordinate: $centerCoordinate)
                    .ignoresSafeArea()
                    .colorScheme(.light)

                /// choose button
                Button {
                    viewModel.getPlacemark(for: centerCoordinate) { placemark in
                        if let placemark {
                            let place = PlaceModel(
                                placemark: placemark,
                                coordinate: centerCoordinate)
                            viewModel.handlePlaceObject(place)
                            dismiss()
                        }
                    }
                } label: {
                    YCapsuleLabel(
                        title: "выбрать",
                        font: CreateEventFont.chooseButtonFont
                    )
                }
            }

            YCircleButton(imageName: "location") {}
        }
    }

}

 #Preview {
     CreateEventPlaceView(
        viewModel: CreateEventViewModel(model: CreateEventModel())
     )
 }
