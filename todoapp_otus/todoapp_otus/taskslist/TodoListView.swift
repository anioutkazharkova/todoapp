//
//  TodoListView.swift
//  todoapp_otus
//
//  Created by Anna Zharkova on 11.05.2022.
//

import SwiftUI
import SwiftUINavigator

struct TodoListView: View, IItemView {
    var listener: INavigationContainer?
    @State var item: TasksList
    
    var body: some View {
        VStack {
            HStack {
                Button("Back") {
                    self.listener?.pop()
                }
                Spacer()
                Text(item.title)
                Spacer()
                Button("Add new task") {
                    self.listener?.push(view: NewTaskView(listId: item.id))
                }
            }.padding(20)
        List {
            ForEach(item.tasks.indices, id: \.self) { index in
                var task = item.tasks[index]
                TaskListRow(task: task).listRowBackground(task.priority.priorityColor()).onTapGesture {
                   task.completed = !task.completed
                    item.tasks[index] = task
                    TasksManager.shared.change(item: task)
                }
            }.onDelete { index in
                item.tasks.remove(atOffsets: index)
                TasksManager.shared.save(list: item)
            }
        }.onAppear {
            TasksManager.shared.load(id: item.id) { data in
                if let data = data {
                    self.item = data
                }
            }
        }
        }
    }
}

