import SwiftUI

struct EventsAccordionHeader: View {

    @ObservedObject var viewModel: EventsAccordionViewModel

    var body: some View {
        Text(viewModel.getHeaderText())
            .fixedSizeText(background: .thinMaterial)
            .padding(.top)
    }

}

