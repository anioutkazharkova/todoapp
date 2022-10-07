//
//  SimpleRow.swift
//  TodoWidgetExtension
//
//  Created by Anna Zharkova on 26.05.2022.
//

import SwiftUI

import SwiftUI

struct SimpleRow: View {
    @State var task: TaskItem
    
    var body: some View {
        HStack(alignment: .top) {
                VStack(alignment: .leading) {
                Text(self.task.title)
                    .fontWeight(.bold)
                    .strikethrough(self.task.completed, color: self.task.priority.priorityColor())
                    .opacity(self.task.completed ? 0.5 : 1)
                
                
                    Text(self.task.dueDate?.formatted() ?? "").fontWeight(.light)
                    Text(self.task.description)
                }
                Spacer()
                Circle()
                    .frame(width: 10)
                    .foregroundColor(self.task.priority.priorityColor())
            }
    }
    }
