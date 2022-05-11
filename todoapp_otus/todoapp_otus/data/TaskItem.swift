//
//  TaskItem.swift
//  todoapp_otus
//
//  Created by Anna Zharkova on 10.05.2022.
//

import Foundation
import SwiftUI


struct TaskItem : Identifiable, Codable {
    let id: UUID
    var title: String
    var description: String
    var date: Date?
    //var theme: Theme
    var dueDate: Date?
    var listId: UUID
    var priority: Priority = .low
    var completed: Bool = false 
    
    init(id: UUID = UUID(), title: String, description: String, listId: UUID, date: Date? = nil, dueDate: Date? = nil) {
        self.id = id
        self.title = title
        //self.theme = theme
        self.date = date
        self.listId = listId
        self.description = description
        self.dueDate = dueDate
    }
}


enum Priority: Int, Codable {
    case low = 0
    case normal = 1
    case high = 2
    
    var priorityType: String {
        switch rawValue {
            case Priority.low.rawValue: return "low"
            case Priority.normal.rawValue: return "normal"
            case Priority.high.rawValue: return "high"
            default: return ""
        }
    }
    
    func priorityColor() -> Color {
        switch rawValue {
            case Priority.low.rawValue: return .green
            case Priority.normal.rawValue: return .orange
            case Priority.high.rawValue: return .red
            default: return .orange
        }
    }
}
