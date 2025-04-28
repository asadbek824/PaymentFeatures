//
//  NotificationService.swift
//  Core
//
//  Created by Akbarshah Jumanazarov on 4/11/25.
//

import Foundation
import UserNotifications

public final class NotificationService {
    
    public init() {
        requestAuthorization()
    }

    private func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("🛑 Notification permission error: \(error)")
                return
            }
        }
    }

    public func scheduleNotification(title: String, body: String, at date: Date) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        let timeInterval = max(date.timeIntervalSinceNow, 1) // must be at least 1 sec
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)

        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("🛑 Failed to schedule notification: \(error)")
            }
        }
    }
}
