import SwiftUI

struct SettingsView: View {
    @AppStorage("soundEnabled") private var soundEnabled = true
    @AppStorage("notificationsEnabled") private var notificationsEnabled = true
    var body: some View {
        VStack(spacing: 36) {
            Text("Settings")
                .font(Font.custom("Righteous", size: 32))
                .frame(maxWidth: .infinity)
            VStack(spacing: 16) {
                NavigationLink(destination: ChooseTreeView().navigationBarBackButtonHidden(true)) {
                    Text("Choose your tree")
                        .font(.system(size: 16))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(red: 0.15, green: 0.15, blue: 0.15))
                        .cornerRadius(16)
                }

                Toggle("Sound", isOn: $soundEnabled)
                    .font(.system(size: 16))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(red: 0.15, green: 0.15, blue: 0.15))
                    .cornerRadius(16)
                    .toggleStyle(SwitchToggleStyle(tint: Color(red: 0.95, green: 0, blue: 0)))
                    .onChange(of: soundEnabled) { newValue in
                        if newValue {
                            AudioManager.shared.playSound()
                        } else {
                            AudioManager.shared.stopSound()
                        }
                    }

                Toggle("Notifications", isOn: $notificationsEnabled)
                    .font(.system(size: 16))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(red: 0.15, green: 0.15, blue: 0.15))
                    .cornerRadius(16)
                    .toggleStyle(SwitchToggleStyle(tint: Color(red: 0.95, green: 0, blue: 0)))
                    .onChange(of: notificationsEnabled) { newValue in
                        if newValue {
                            NotificationManager.shared.requestPermission()
                            NotificationManager.shared.scheduleDailyNotification()
                        } else {
                            NotificationManager.shared.cancelNotifications()
                        }
                    }
                Button(action: {
                    openT("https://www.termsfeed.com/live/24f10ec5-d0fc-405c-8236-1a26fdbf4d33")
                }, label: {
                    Text("Terms of Use")
                        .font(.system(size: 16))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(red: 0.15, green: 0.15, blue: 0.15))
                        .cornerRadius(16)
                })
            }
        }
        .padding()
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background {
            Image(.backBlackScreen)
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
        }
    }
    
    private func openT(_ urlString: String) {
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
}

#Preview {
    SettingsView()
}
