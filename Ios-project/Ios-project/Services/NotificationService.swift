//
//  NotificationService.swift
//  Ios-project
//
//  Created by student3 on 2026-07-08.
//

import Foundation
import UserNotifications


class NotificationService {

    static let shared = NotificationService()

    func requestPermission() {

        UNUserNotificationCenter.current()
            .requestAuthorization(
                options: [.alert, .sound, .badge]
            ) { granted, error in

                if granted {
                    print("Notification permission granted")
                } else {
                    print("Notification permission denied")
                }

                if let error = error {
                    print(error.localizedDescription)
                }
            }
    }

    func scheduleDailyNotification(
        hour: Int,
        minute: Int
    ) {

        let content = UNMutableNotificationContent()

        content.title = "Daily challenge "
        content.body = "Come back and beat your high score!"
        content.sound = .default

        var date = DateComponents()

        date.hour = hour
        date.minute = minute

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: date,
            repeats: true
        )

        let request = UNNotificationRequest(
            identifier: "dailyChallenge",
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(
                withIdentifiers: ["dailyChallenge"]
            )

        UNUserNotificationCenter.current()
            .add(request) { error in

                if let error = error {
                    print(
                        "Notification scheduling error:",
                        error.localizedDescription
                    )
                }
            }
    }

    func removeDailyNotification() {

        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(
                withIdentifiers: ["dailyChallenge"]
            )
    }

}
