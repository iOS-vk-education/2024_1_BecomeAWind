import SwiftUI
import Combine

struct MakeEventDescription: View {
    @ObservedObject var viewModel: MakeEventViewModel
    
     var body: some View {
         MakeEventTextField(
            text: $viewModel.eventDescription,
            title: "Описание",
            prompt: "Опиши данное событие",
            lineLimit: MakeEventConst.lineLimit
         )
         .onReceive(Just(viewModel.eventDescription)) { _ in
             viewModel.limitTextField(
                 MakeEventConst.titleMaxLength,
                 text: $viewModel.eventTitle
             )
         }
     }
 }
