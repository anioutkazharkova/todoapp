//
//  TodoView.swift
//  todoapp_otus
//
//  Created by Anna Zharkova on 11.05.2022.
//

import SwiftUI

struct TodoView: View {
    @State var item: TasksList
    
    var body: some View {
        VStack {
            Text(item.title).fontWeight(.semibold)
            ForEach(item.tasks.prefix(3).indices, id: \.self) { index in
                let task = item.tasks[index]
                TaskRow(item: task).listRowBackground(task.priority.priorityColor())
            }
            if item.tasks.count > 3 {
                Text("Show more...").foregroundColor(.white)
            }
        }.cornerRadius(20).padding(20).frame(
            minWidth: 0,
            maxWidth: .infinity,
            alignment: .topLeading
          )
    }
}

