import SwiftUI

struct GameStartView: View {
    var body: some View {
        VStack {
            VStack(spacing: 36) {
                Text("Tap the Trees!")
                    .font(Font.custom("Righteous", size: 32))
                    .frame(maxWidth: .infinity)
                
                Text("Focus and react quickly!\nTrees will appear randomly on your screen. \nTap on them as quickly as you can before they disappear")
                    .multilineTextAlignment(.center)
            }
            
            Image(.trees)
                .resizable()
                .scaledToFit()
                .padding(.horizontal)
                .padding(.top)
            
            NavigationLink(destination: GameView().navigationBarBackButtonHidden(true)) {
                Text("Begin the Challenge")
                    .font(Font.custom("Righteous", size: 18))
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 0.95, green: 0, blue: 0))
                    .cornerRadius(16)
            }
            
        }
        .foregroundColor(.white)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background {
            Image(.backBlackScreen)
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
        }
    }
}

#Preview {
    GameStartView()
}
