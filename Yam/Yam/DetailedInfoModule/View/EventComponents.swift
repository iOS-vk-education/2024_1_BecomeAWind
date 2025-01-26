import SwiftUI

struct EventImage: View {
    var image: UIImage

    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFill()
            .frame(height: 200)
            .clipped()
            .cornerRadius(30, corners: [.topLeft, .topRight])
            .overlay(
                LinearGradient(
                    gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.6)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
    }
}

struct EventTitle: View {
    var title: String

    var body: some View {
        Text(title)
            .font(.system(size: 30))
            .bold()
            .foregroundColor(.white)
            .padding()
    }
}

struct EventDescriptionView: View {
    var descriprion: String

    var body: some View {
        Text(descriprion)
            .font(.body)
            .foregroundColor(.white)
            .padding(.horizontal)
    }
}

// MARK: - detail info event

struct ContentItemEvent: View {
    var title: String
    var data: String

    var body: some View {
        HStack {
            EventInfoView(text: title)
            Spacer()
            EventInfoView(text: data, color: .green)
        }
    }
}

struct EventInfoView: View {
    var text: String
    var color: Color = .white

    var body: some View {
        Text(text)
            .foregroundColor(color)
    }
}
