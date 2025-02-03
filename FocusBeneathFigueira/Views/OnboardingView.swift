import SwiftUI

struct OnboardingView: View {
    @State private var currentIndex = 0
    let close: () -> Void
    
    private let pages: [(title: String, description: String, image: ImageResource)] = [
        (
            "Discover the art of focus and \nbalance",
            "Discover the art of focus and mindfulness under the wisdom of the Figueira tree. Ready to grow your balance and productivity?",
            .fig
        ),
        (
            "Stay Organized and Focused\n",
            "Use the Focus Timer to stay on track. Manage your tasks effortlessly with To-Do Lists. Learn with inspiring articles about mindfulness, time management, and nature.",
            .orange
        ),
        (
            "Play and Personalize\n",
            "Enjoy a relaxing mini-game to sharpen your focus. Customize beautiful trees and make your journey uniquely yours.",
            .lemon
        )
    ]
    
    var body: some View {
        VStack {
            Image(pages[currentIndex].image)
                .resizable()
                .scaledToFit()
                .padding()
            
            VStack(spacing: 12) {
                Text(pages[currentIndex].title)
                    .multilineTextAlignment(.center)
                    .font(Font.custom("Righteous", size: 20))
                Text(pages[currentIndex].description)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 16, weight: .light))
            }
            .padding(12)
            .frame(maxWidth: .infinity)
            .background(Color(red: 0.15, green: 0.15, blue: 0.15))
            .cornerRadius(16)
            
            HStack(spacing: 8) {
                ForEach(0..<pages.count, id: \..self) { index in
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: currentIndex == index ? 24 : 12, height: 12)
                        .foregroundColor(currentIndex == index ? Color(red: 0.95, green: 0, blue: 0) : Color(red: 0.15, green: 0.15, blue: 0.15))
                }
            }
            .padding(.vertical, 12)
            
            HStack {
                if !(currentIndex == pages.count - 1) {
                    Button(action: {
                        currentIndex = pages.count - 1
                    }, label: {
                        Text("Skip")
                            .font(Font.custom("Righteous", size: 20))
                    })
                }
                
                Spacer()
                
                Button(action: {
                    if currentIndex < pages.count - 1 {
                        currentIndex += 1
                    } else {
                       close()
                    }
                }, label: {
                    Text(currentIndex == pages.count - 1 ? "Start" : "Next")
                        .font(Font.custom("Righteous", size: 18))
                        .padding(.vertical, 12)
                        .frame(maxWidth: currentIndex == pages.count - 1 ? .infinity : 136)
                        .background(Color(red: 0.95, green: 0, blue: 0))
                        .cornerRadius(16)
                })
            }
            .padding()
        }
        .padding()
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .background {
            Image(.backBlackScreen)
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
        }
    }
}

#Preview {
    OnboardingView() {}
}
