/*
 MARK: - Buttons on map
// Buttons
VStack {
    // Top buttons
    HStack {
        // Profile button
        VStack {
            Button {
                profileActive.toggle()
            } label: {
                Image(systemName: "person.fill")
                    .foregroundColor(.white)
                    .font(.system(size: 25))
            }
            .sheet(isPresented: $profileActive) {
                ProfileView()
            }
        }
        .padding(10)
        .background(.black)
        .clipShape(Circle())

        Spacer()

        // Center on user location button
        VStack {
            Button {
//                            centerOnUserLocation()
            } label: {
                Image(systemName: "location.fill")
                    .foregroundColor(.white)
                    .font(.system(size: 25))
            }
        }
        .padding(10)
        .background(.black)
        .clipShape(Circle())
    }
    .padding()

    Spacer()
}
 */
