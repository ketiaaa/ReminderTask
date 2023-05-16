//
//  Task.swift
//  ReminderTask
//
//  Created by ketia  on 16/5/2023.
//

import SwiftUI

struct Task: Identifiable, Codable {
    var id = UUID()
    var title: String
    var dueDate: Date
    var priority: String
    var isCompleted: Bool = false
}
