import SwiftUI

struct MapClusterView: View {

    let count: Int

    var body: some View {
        CircleLabel(count: count, font: MapConst.clusterCountFont)
    }

}

#Preview {
    MapClusterView(count: 13)
}
