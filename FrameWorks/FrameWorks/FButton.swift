import SwiftUI

struct FButton: View {
    let title: String
    var width: CGFloat = 280
    var height: CGFloat = 50
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
                .frame(width: width, height: height)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}

#Preview {
    FButton(
        title: "Tap Me",
        width: 280,
        height: 50,
        action: {
            print("Button tapped")
        }
    )
}

