//
//  ReminderTaskApp.swift
//  ReminderTask
//
//  Created by ketia  on 16/5/2023.
//

import SwiftUI
import UserNotifications

@main
struct ReminderTaskApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(TaskManager())
                .onAppear {
                    NotificationManager.shared.requestAuthorization()
                }
        }
    }
}

class NotificationManager {
    static let shared = NotificationManager()
    private init() {}
    
    func scheduleNotification(for task: Task) {
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "Task: \(task.title)"
        content.sound = UNNotificationSound.default
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: task.dueDate)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        let request = UNNotificationRequest(identifier: task.id.uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully")
            }
        }
    }
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { _, error in
            if let error = error {
                print("Error requesting notification authorization: \(error.localizedDescription)")
            }
        }
    }
}
