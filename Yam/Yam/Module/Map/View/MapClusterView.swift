import SwiftUI

struct MapClusterView: View {

    let count: Int
    let action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            CircleLabel(count: count, font: Const.clusterCountFont)
        }
    }

}

