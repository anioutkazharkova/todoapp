//
//  TodoListEntryView.swift
//  todo
//
//  Created by Anna Zharkova on 12.05.2022.
//

import SwiftUI
import WidgetKit

struct TodoListEntryView : View {
    var entry: SimpleEntry
    var tasks: [TaskItem] {
        return Array(entry.item.tasks.prefix(3))
    }

    var body: some View {
        VStack(alignment: .leading){HStack {
                    Text(entry.item.title)
                        .font(.headline.bold())
                        .foregroundColor(.white)
                        .tint(.white)
                        .colorMultiply(.white).padding(.horizontal)
                
                    Spacer()
            Text(entry.item.completedText)
                        .font(.callout)
                        .foregroundColor(.white)
                        .tint(.white)
                        .colorMultiply(.white).padding(.horizontal)
                
                }.frame(maxWidth: .infinity, minHeight: 40).background(.orange)
                
            ForEach(tasks) { item in
                    SimpleRow(task: item)
                }
            Spacer()
            Divider()
            Text("Add task +").foregroundColor(.gray).frame(height: 40).padding()
            }
        }
}

struct TodoListEntryView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListEntryView(entry: SimpleEntry(date: .now, item: TasksList(title: "Test list"))).previewContext(WidgetPreviewContext(family: .systemExtraLarge))
    }
}

struct SimpleRow : View {
    var task: TaskItem
    
    var body: some View {
        HStack {
            
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
    }
}
