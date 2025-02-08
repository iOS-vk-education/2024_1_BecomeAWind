import SwiftUI

public enum GradientPack {
    static let purpleIndigo = LinearGradient(colors: [.purple, .indigo], startPoint: .top, endPoint: .bottom)
    static let orangePurple = LinearGradient(colors: [.orange, .purple], startPoint: .top, endPoint: .bottom)
    static let purpleOrange = LinearGradient(colors: [.purple, .orange], startPoint: .top, endPoint: .bottom)
    static let greenPurple = LinearGradient(colors: [.green, .indigo], startPoint: .top, endPoint: .bottom)
    static let blackPurple = LinearGradient(colors: [ColorPack.black, ColorPack.purple], startPoint: .top, endPoint: .bottom)
    static let purpleBlack = LinearGradient(colors: [ColorPack.black, ColorPack.purple], startPoint: .bottom, endPoint: .top)
    static let black = LinearGradient(colors: [ColorPack.black, ColorPack.black], startPoint: .top, endPoint: .bottom)
    static let clear = LinearGradient(colors: [ColorPack.clear, ColorPack.clear], startPoint: .top, endPoint: .bottom)
}
