//
//  ContentView.swift
//  ReminderTask
//
//  Created by ketia  on 16/5/2023.
//

import SwiftUI

private var dateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter
}
struct ContentView: View {
    @EnvironmentObject private var taskManager: TaskManager
    @State private var showingCreateTaskSheet = false

    var body: some View {
        NavigationView {
            List {
                ForEach(taskManager.tasks) { task in
                    TaskView(task: task)
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        taskManager.deleteTask(taskManager.tasks[index])
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Tasks")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingCreateTaskSheet = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingCreateTaskSheet) {
                CreateTaskView()
            }
        }
    }
}

struct TaskView: View {
    var task: Task
    @EnvironmentObject private var taskManager: TaskManager
    var body: some View {
        HStack {
            Text(task.title)
            Spacer()
            Text(task.dueDate, formatter: dateFormatter)
        }
        .contextMenu {
            Button(action: {
            }) {
                Text("Edit")
                Image(systemName: "pencil")
            }
        }
        .swipeActions(edge: .leading) {
            Button(action: {
                // Delete task action
                deleteTask()
            }) {
                Image(systemName: "trash")
            }
            .tint(.red)
        }
    }

    private func deleteTask() {
        // Call the deleteTask method from TaskManager
        taskManager.deleteTask(task)
    }
}

struct CreateTaskView: View {
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject private var taskManager: TaskManager // Use @EnvironmentObject to access TaskManager

    @State private var title = ""
    @State private var dueDate = Date()
    @State private var priority = ""

    var body: some View {
        NavigationView {
            Form {
                TextField("Task Title", text: $title)
                DatePicker("Due Date", selection: $dueDate, displayedComponents: [.date])
                TextField("Priority", text: $priority)
            }
            .navigationTitle("Create Task")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Save") {
                        let newTask = Task(title: title, dueDate: dueDate, priority: priority)
                        taskManager.createTask(newTask)
                        NotificationManager.shared.scheduleNotification(for: newTask)
                            presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
