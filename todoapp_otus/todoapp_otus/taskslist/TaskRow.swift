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
        HStack {
            Text(item.title).strikethrough(item.completed, color: .black)
            Spacer()
            Text(item.dueDate?.formatted() ?? "")
        }.background(item.priority.priorityColor()).frame(maxHeight: 80)
    }
}

