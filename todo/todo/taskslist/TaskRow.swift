//
//  TaskRow.swift
//  todoapp_otus
//
//  Created by Anna Zharkova on 11.05.2022.
//

import SwiftUI

struct TaskRow: View {
    @State var item: TaskItem
    var body: some View {
        VStack(alignment: .leading ,spacing: 20) {
            Text(item.title).strikethrough(item.completed, color: .black)
            Text("Due date: \(item.dueDate?.formatted() ?? "")")
            if !item.description.isEmpty {
                Text(item.description).frame(minHeight: 80)
            }
        }.frame(maxWidth: .infinity)
    }
}

