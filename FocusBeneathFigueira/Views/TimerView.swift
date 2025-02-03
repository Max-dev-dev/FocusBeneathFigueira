import SwiftUI

struct TimerView: View {
    @State private var isRunning = false
    @State private var isPaused = false
    @State private var totalSeconds: Int = 1500
    @State private var initialTime: Int = 1500
    @State private var timer: Timer? = nil
    @ObservedObject var treeManager = TreeSelectionManager.shared

    var body: some View {
        VStack(spacing: 32) {
            Image(treeManager.selectedTree)
                .resizable()
                .scaledToFit()
                .padding()

            HStack {
                if !isRunning {
                    Button(action: {
                        adjustTime(by: -10)
                    }, label: {
                        Image(systemName: "chevron.down")
                            .frame(width: 32, height: 32)
                            .padding(8)
                            .background(Color(red: 0.15, green: 0.15, blue: 0.15))
                            .cornerRadius(16)
                    })
                }

                Spacer()

                Text(formatTime(totalSeconds))
                    .font(Font.custom("Righteous", size: 40))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)

                Spacer()

                if !isRunning {
                    Button(action: {
                        adjustTime(by: 10)
                    }, label: {
                        Image(systemName: "chevron.up")
                            .frame(width: 32, height: 32)
                            .padding(8)
                            .background(Color(red: 0.15, green: 0.15, blue: 0.15))
                            .cornerRadius(16)
                    })
                }
            }

            if isPaused {
                VStack(spacing: 24) {
                    Button(action: {
                        resumeTimer()
                    }, label: {
                        Text("Continue")
                            .font(Font.custom("Righteous", size: 32))
                                                        .multilineTextAlignment(.center)
                                                        .foregroundColor(Color(red: 0.41, green: 0.41, blue: 0.41))
                    })

                    Button(action: {
                        resetTimer()
                    }, label: {
                        Text("Reset")
                            .font(Font.custom("Righteous", size: 32))
                                                        .multilineTextAlignment(.center)
                                                        .foregroundColor(Color(red: 0.41, green: 0.41, blue: 0.41))
                    })
                }
            } else {
                Button(action: {
                    if isRunning {
                        pauseTimer()
                    } else {
                        startTimer()
                    }
                }, label: {
                    Text(isRunning ? "Stop" : "Start")
                        .font(Font.custom("Righteous", size: 32))
                                               .multilineTextAlignment(.center)
                                               .foregroundColor(Color(red: 0.41, green: 0.41, blue: 0.41))
                })
            }
        }
        .foregroundColor(.white)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Image(.backBlackScreen)
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
        }
    }

    private func adjustTime(by seconds: Int) {
        guard !isRunning else { return }
        let newTime = totalSeconds + seconds
        totalSeconds = max(0, newTime)
        initialTime = totalSeconds
    }

    private func formatTime(_ totalSeconds: Int) -> String {
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }

    private func startTimer() {
        isRunning = true
        isPaused = false
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if totalSeconds > 0 {
                totalSeconds -= 1
            } else {
                stopTimer()
            }
        }
    }

    private func pauseTimer() {
        isPaused = true
        timer?.invalidate()
    }

    private func resumeTimer() {
        isPaused = false
        startTimer()
    }

    private func resetTimer() {
        timer?.invalidate()
        isRunning = false
        isPaused = false
        totalSeconds = initialTime
    }

    private func stopTimer() {
        timer?.invalidate()
        isRunning = false
        isPaused = false
    }
}


#Preview {
    TimerView()
}
