import SwiftUI

struct EventCardLoadingButton<Background: ShapeStyle>: View {

    let background: Background

    var body: some View {
        EventCardVStack {
            GradientLoader(background: background)
        }
    }

}
