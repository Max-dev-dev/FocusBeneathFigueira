import SwiftUI

struct GameView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var progress: CGFloat = 1.0
    @State private var score = 0
    @State private var gameOver = false
    @State private var isPaused = false
    @State private var treePosition = CGPoint(x: 200, y: 300)
    @State private var timer: Timer?
    @State private var currentTree = "apple"
    let treeIcons = ["apple", "fig", "lemon", "orange", "pear", "plum"]
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        pauseGame()
                    }) {
                        Image(.pauseButton)
                    }
                }
                .padding()

                ProgressView(value: progress)
                    .progressViewStyle(LinearProgressViewStyle())
                    .frame(height: 8)
                    .padding()
                    .accentColor(.white)
                
                Spacer()
                
                Image(currentTree)
                    .resizable()
                    .frame(width: 88, height: 88)
                    .position(treePosition)
                    .foregroundColor(.green)
                    .onTapGesture {
                        score += 1
                        moveTree()
                    }
                
                Spacer()
            }
            
            if gameOver {
                Color.black.opacity(0.5).ignoresSafeArea()
                VStack(spacing: 20) {
                    Text("Game Over")
                        .font(Font.custom("Righteous", size: 32))
                        .foregroundColor(.white)
                    
                    Text("Your score: \(score)")
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                    
                    Button(action: {
                        gameOver = false
                        resetGame()
                    }) {
                        Text("Play Again")
                            .font(.system(size: 18))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    
                    Button(action: {
                        gameOver = false
                        score = 0
                        progress = 1.0
                        dismiss()
                    }) {
                        Text("Quit Game")
                            .font(.system(size: 18))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }
                .padding()
                .frame(width: 300)
                .background(Color.black.opacity(0.8))
                .cornerRadius(20)
            }
        }
        .onAppear {
            startGame()
        }
    }
    
    private func startGame() {
        progress = 1.0
        score = 0
        gameOver = false
        isPaused = false
        startTimer()
    }
        
    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if progress > 0 {
                progress -= 0.0167
            } else {
                timer?.invalidate()
                gameOver = true
            }
        }
    }
        
    private func moveTree() {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let newX = CGFloat.random(in: 50...(screenWidth - 50))
        let newY = CGFloat.random(in: 150...(screenHeight - 250))
        treePosition = CGPoint(x: newX, y: newY)
            
        currentTree = treeIcons.randomElement() ?? "apple"
    }
        
    private func pauseGame() {
        timer?.invalidate()
        isPaused = true
        showPauseAlert()
    }
        
    private func resumeGame() {
        isPaused = false
        startTimer()
    }
        
    private func resetGame() {
        startGame()
        moveTree()
    }
    
    private func showPauseAlert() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController
        else {
            return
        }
            
        let alert = UIAlertController(title: "Game Paused",
                                      message: "The game is on hold. Ready to jump back in or take a fresh start?",
                                      preferredStyle: .alert)
            
        alert.addAction(UIAlertAction(title: "Resume", style: .default, handler: { _ in
            resumeGame()
        }))
            
        alert.addAction(UIAlertAction(title: "Start Over", style: .default, handler: { _ in
            resetGame()
        }))
            
        alert.addAction(UIAlertAction(title: "Quit Game", style: .destructive, handler: { _ in
            dismiss()
        }))
            
        rootViewController.present(alert, animated: true, completion: nil)
    }
}

#Preview {
    GameView()
}
