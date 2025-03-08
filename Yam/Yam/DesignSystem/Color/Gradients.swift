import SwiftUI

enum Gradients {
    static let purpleIndigo = LinearGradient(colors: [.purple, .indigo], startPoint: .top, endPoint: .bottom)
    static let orangePurple = LinearGradient(colors: [.orange, .purple], startPoint: .top, endPoint: .bottom)
    static let purpleOrange = LinearGradient(colors: [.purple, .orange], startPoint: .top, endPoint: .bottom)
    static let greenPurple = LinearGradient(colors: [.green, .indigo], startPoint: .top, endPoint: .bottom)
    static let blackPurple = LinearGradient(colors: [Colors.black, Colors.purple], startPoint: .top, endPoint: .bottom)
    static let black = LinearGradient(colors: [Colors.black, Colors.black], startPoint: .top, endPoint: .bottom)
    static let clear = LinearGradient(colors: [Colors.clear, Colors.clear], startPoint: .top, endPoint: .bottom)
}
