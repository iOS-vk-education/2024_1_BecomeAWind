import SwiftUI
import FirebaseFirestore

struct MakeEventFooterButton: View {

    @ObservedObject var viewModel: MakeEventViewModel
    let action: () -> Void
    private let db = Firestore.firestore()

    var body: some View {
        Button {
            if viewModel.handleEvent() {
                if let location = viewModel.location {
                    viewModel.updatePlace(from: viewModel.placeDescription, location: location)
                    if let geoPoint = viewModel.geoPoint {
                        db.collection("events").addDocument(data: [
                            "title": viewModel.eventTitle,
                            "description": viewModel.eventDescription,
                            "link": viewModel.link,
                            "date": viewModel.date,
                            "seats": viewModel.seatsFb,
                            "placeDescription": viewModel.placeDescription,
                            "place": geoPoint
                        ])
                    }
                    action()
                }
            } else {
                viewModel.toggleEventHandlingFailed()
            }
                
        } label: {
            YCapsuleLabel(
                title: viewModel.footerButtonText,
                font: Const.buttonFont
            )
        }
    }

}

#Preview {
    MakeEventFooterButton(viewModel: MakeEventViewModel(), action: {})
}
