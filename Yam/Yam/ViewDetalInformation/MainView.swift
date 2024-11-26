//
//  MainView.swift
//  Yam
//
//  Created by Ширапов Арсалан on 16.11.2024.
//

import SwiftUI

struct Main: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

var title:some View{
    
    Text("События")
        .frame(alignment: .center)
        .font(.largeTitle)
        .colorInvert()
//        .background(.blue)
}
var backButton:some View{
    Button(
        action:{},
        label:{
            Image(systemName: "x.circle.fill")
                .accentColor(Color.gray)
                
        }
    )
}

struct swipeAction:View {
    private let colors:[Color] = [Color(UIColor(named: "ViewDetalGray")!), .gray, .green, .red, .blue, .black, .yellow ]
    var body: some View {
        VStack{
        
            TabView{
                ForEach(colors, id:\.self){ color in
                    ZStack{
                        color
                        Text("")
                        
                    }
                }
            }
            .tabViewStyle(.page)
            .frame(height: 650)
            .cornerRadius(30)
            Spacer()
        }
    }
}
var actionRightButton:some View{
    Button(
        action:{},
        label:{
            Image("arrowRight")
                .resizable()
                .frame(width: 60,height: 60)
                .accentColor(Color.gray)
                .padding(5)
                .background(Color(UIColor(named: "ViewDetalGray")!))
                .clipShape(RoundedRectangle(cornerRadius: 15))
//                .background(.red)
        }
    )
}
var actionLeftButton:some View{
    Button(
        action:{},
        label:{
            Image("arrowLeft")
                .resizable()
                .frame(width: 60,height: 60)
                .accentColor(Color.gray)
                .padding(5)
                .background(Color(UIColor(named: "ViewDetalGray")!))
                .clipShape(RoundedRectangle(cornerRadius: 15))
            
//                .background(.red)
        }
    )
}
//var lentaButton:some View{
//    Button(
//        action:{},
//        label:{
//            Image("Lenta")
//                .resizable()
//                .frame(width: 50, height: 50)
//                .colorInvert()
//                .padding(5)
//                .background(Color(UIColor(named: "ViewDetalBlack")!))
//                .clipShape(RoundedRectangle(cornerRadius: 5))
//        }
//    )
//}
//var backToMapButton:some View{
//    Button(
//        action:{},
//        label:{
//            Image(systemName: "map")
//                .resizable()
//                .frame(width: 50, height: 50)
////                .colorInvert()
//                .padding(5)
//                .background(Color(UIColor(named: "ViewDetalBlack")!))
//                .clipShape(RoundedRectangle(cornerRadius: 5))
//                .accentColor(Color.white)
//        }
//    )
//}

struct Heading: View {
    var body: some View {
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        HStack {
            Spacer()
            title
            Spacer()
            backButton
        }
        .padding()
    }
}

struct mainBody:View {
    var body: some View {
        VStack {
            
                swipeAction()
                Image("Image")
            
        }
    }
}
struct activityButtons:View {
    var body: some View {
        HStack {
            Spacer()
            actionLeftButton
            Spacer()
            Spacer()
            actionRightButton
            Spacer()
        }
    }
}
struct allScreen:View {
    var body: some View {
        VStack{
            Heading()
            mainBody()
//            activityButtons()
  //          HStack{
  //              lentaButton
  //              backToMapButton
  //          }
            
        }
        .padding()
//        .background(Color(UIColor(named: "ViewDetalBlack")!))
        .frame(height: 905)
        .background(Color(UIColor(named: "ViewDetalBlack")!))
        
    }
}

struct EventView_Previews: PreviewProvider {
  static var previews: some View {
      allScreen()
  }
}
