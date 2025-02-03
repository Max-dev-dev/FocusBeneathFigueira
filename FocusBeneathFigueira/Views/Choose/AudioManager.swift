import SwiftUI
import AVFoundation
import UserNotifications

class AudioManager {
    static let shared = AudioManager()
    private var player: AVAudioPlayer?

    func playSound() {
        guard let url = Bundle.main.url(forResource: "timersound", withExtension: "wav") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = -1
            player?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }

    func stopSound() {
        player?.stop()
    }
}

class NotificationManager {
    static let shared = NotificationManager()

    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Notification permission error: \(error.localizedDescription)")
            }
        }
    }

    func scheduleDailyNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Focus Beneath Figueira"
        content.body = "Time to focus beneath the Figueira! 🌳 Tap to start your session and grow your productivity today"
        content.sound = .default

        var dateComponents = DateComponents()
        dateComponents.hour = 9
        dateComponents.minute = 0

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "daily_focus_reminder", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            }
        }
    }

    func cancelNotifications() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["daily_focus_reminder"])
    }
}
