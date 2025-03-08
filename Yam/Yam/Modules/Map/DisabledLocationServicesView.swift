import SwiftUI
import _MapKit_SwiftUI

struct DisabledLocationServicesView: View {
    var body: some View {
        ZStack {
            Map(interactionModes: [])
            Colors.black
                .opacity(0.5)
                .ignoresSafeArea()

            VStack {
                Text("службы геолокации выключены.\nвключи их в настройках.")
                    .font(.headline)
                    .fontWeight(.heavy)
                    .foregroundColor(Colors.white)
                    .padding()

                Button {
                    if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(appSettings)
                    }
                } label: {
//                    YamCapsuleLabel(title: "открыть настройки", background: GradientPack.purpleIndigo)
                }
                .padding(.bottom)
            }
            .padding()
            .background(Colors.black)
            .cornerRadius(SizePack.coreCornerRadius)
        }
    }
}

#Preview {
    DisabledLocationServicesView()
}
