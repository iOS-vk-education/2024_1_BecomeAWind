import SwiftUI

public enum GradientsPack {
    static let purpleIndigo = LinearGradient(colors: [.purple, .indigo], startPoint: .top, endPoint: .bottom)
    static let orangePurple = LinearGradient(colors: [.orange, .purple], startPoint: .top, endPoint: .bottom)
    static let purpleOrange = LinearGradient(colors: [.purple, .orange], startPoint: .top, endPoint: .bottom)
    static let greenPurple = LinearGradient(colors: [.green, .indigo], startPoint: .top, endPoint: .bottom)
    static let blackPurple = LinearGradient(colors: [ColorsPack.black, ColorsPack.purple], startPoint: .top, endPoint: .bottom)
    static let black = LinearGradient(colors: [ColorsPack.black, ColorsPack.black], startPoint: .top, endPoint: .bottom)
    static let clear = LinearGradient(colors: [ColorsPack.clear, ColorsPack.clear], startPoint: .top, endPoint: .bottom)
}
