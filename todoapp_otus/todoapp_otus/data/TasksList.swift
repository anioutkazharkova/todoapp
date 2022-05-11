//
//  TasksList.swift
//  todoapp_otus
//
//  Created by Anna Zharkova on 10.05.2022.
//

import Foundation

struct TasksList: Identifiable, Codable {
    let id: UUID
    var title: String
    var date: Date? = nil
    var dueDate: Date? = nil
    var tasks: [TaskItem] = [TaskItem]()
    
    init(id: UUID = UUID(), title: String, tasks: [TaskItem] = [TaskItem](),  date: Date? = nil, dueDate: Date? = nil) {
        self.id = id
        self.title = title
        self.date = date
        self.tasks = tasks.map{$0}
        self.dueDate = dueDate
    }
}
