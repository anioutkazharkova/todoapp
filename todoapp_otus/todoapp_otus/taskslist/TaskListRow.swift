//
//  TaskListRow.swift
//  todoapp_otus
//
//  Created by Anna Zharkova on 11.05.2022.
//

import SwiftUI

struct TaskListRow: View {
    @State var task: TaskItem
    
    var body: some View {
        Toggle(isOn: self.$task.completed){
            HStack {
                Text(self.task.title)
                    .fontWeight(.bold)
                    .strikethrough(self.task.completed, color: .black)
                    .opacity(self.task.completed ? 0.5 : 1)
                
                Spacer()
                Text(self.task.dueDate?.formatted() ?? "")
                Circle()
                    .frame(width: 10)
                    .foregroundColor(self.task.priority.priorityColor())
            }
        }
    }
}
