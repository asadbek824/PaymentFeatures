//
//  NotificationService.swift
//  Core
//
//  Created by Akbarshah Jumanazarov on 4/11/25.
//

import Foundation
import UserNotifications

final class NotificationManager {
    
    static let shared = NotificationManager()

    private init() {}

    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("🛑 Notification permission error: \(error)")
                return
            }

            print(granted ? "✅ Notifications granted" : "🚫 Notifications denied")
        }
    }

    func scheduleNotification(title: String, body: String, at date: Date) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        let triggerDate = Calendar.current.dateComponents(
            [.year, .month, .day, .hour, .minute, .second],
            from: date
        )

        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)

        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("🛑 Failed to schedule notification: \(error)")
            } else {
                print("📬 Notification scheduled for \(date)")
            }
        }
    }
}
