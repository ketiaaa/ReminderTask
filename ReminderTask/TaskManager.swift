//
//  TaskManager.swift
//  ReminderTask
//
//  Created by ketia  on 16/5/2023.
//

import SwiftUI
import UserNotifications

class TaskManager: ObservableObject {
    @Published var tasks: [Task] = []
    
    init() {
        loadTasks()
    }
    
    func createTask(_ task: Task) {
        tasks.append(task)
        saveTasks()
    }
    
    func deleteTask(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks.remove(at: index)
            saveTasks()
        }
    }
    
    private func saveTasks() {
        do {
            let encodedData = try JSONEncoder().encode(tasks)
            UserDefaults.standard.set(encodedData, forKey: "tasks")
        } catch {
            print("Error saving tasks: \(error.localizedDescription)")
        }
    }
    
    private func loadTasks() {
        if let data = UserDefaults.standard.data(forKey: "tasks") {
            do {
                tasks = try JSONDecoder().decode([Task].self, from: data)
            } catch {
                print("Error loading tasks: \(error.localizedDescription)")
            }
        }
    }
}
