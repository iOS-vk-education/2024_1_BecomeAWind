import SwiftUI

enum ProfileSegment {
    case yours
    case subscriptions
}

struct ProfileView: View {

    @StateObject private var viewModel = ProfileViewModel()
//    @State private var segment: ProfileSegment = .yours

    var body: some View {
        VStack {
            YCircleButton(imageName: "plus") {
                viewModel.toggleCreateEvent()
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing, Const.sideSpace)
            
            Spacer()
        }
        .fullScreenCover(
            isPresented: $viewModel.isActiveCreateEvent
        ) {
            CreateEventView()
        }

        /*
        NavigationStack {
            Form {
                Picker("", selection: $segment) {
                    Text("твои").tag(ProfileSegment.yours)
                    Text("подписки").tag(ProfileSegment.subscriptions)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                //                Section {
                //                    Picker("", selection: $segment) {
                //                        Text("твои").tag(MyEventsSegment.yours)
                //                        Text("подписки").tag(MyEventsSegment.subscriptions)
                //                    }
                //                    .pickerStyle(.segmented)
                //                    .padding(.horizontal)
                //                }
                //
                //                Section {
                //                    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                //                }
                //
                //                Section {
                //                    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                //                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    //                    YamText("ивенты",
                    //                            fontSize: SizePack.headerTextFontSize)
                }

                ToolbarItem {
                    Button {
                        viewModel.toggleCreateEvent()
                    } label: {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                        }
                        .foregroundColor(Colors.purple)
                    }
                }
            }


        }
         */
    }
}

#Preview {
    ProfileView()
}
