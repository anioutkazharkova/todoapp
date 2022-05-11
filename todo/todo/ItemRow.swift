//
//  ItemRow.swift
//  ToFu
//
//  Created by Bri on 2/2/22.
//

import SwiftUI

struct ItemCompletedButton: View {
    @Binding var completed: Bool
    var update: () async -> ()
    var body: some View {
        Button {
            completed.toggle()
            Task {
                await update()
            }
        } label: {
            Image(systemName: completed ? "cube.fill" : "cube").transition(.scale)
        }
        .buttonStyle(.plain)
    }
}

struct ItemRow: View {
    @State var task: TaskItem
    @FocusState var focused
    
    
    
    var body: some View {
        HStack {
            ItemCompletedButton(completed: $task.completed, update: {
                TasksManager.shared.saveTask(item: task)
            })

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(task.title)
                        .foregroundColor(task.completed ? .gray : .primary).strikethrough(task.completed, color: .black)
                    Spacer()
                    Circle().frame(width: 10, height: 10, alignment: .center).foregroundColor(task.priority.priorityColor())
                }
                Text(task.description)
                        .font(.callout)
                        .foregroundStyle(.secondary)
                if let due = task.dueDate {
                    (Text("Due: ") + Text(due.formatted(date: .numeric, time: .shortened)))
                        .font(.callout)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Button {
                    focused = false
                } label: {
                    Image(systemName: "keyboard.chevron.compact.down")
                }
            }
        }
    }
}
