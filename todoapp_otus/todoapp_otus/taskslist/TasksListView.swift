//
//  TasksListView.swift
//  todoapp_otus
//
//  Created by Anna Zharkova on 10.05.2022.
//

import SwiftUI
import SwiftUINavigator

struct TasksListView: View, IItemView {
    var listener: INavigationContainer?
    @ObservedObject var model = TasksListViewModel()
    
    var body: some View {
        VStack{
            HStack {
                Spacer()
                Button("Add") {
                    self.listener?.push(view: NewTaskList())
                }
            }.padding(20)
        List {
            ForEach(model.lists) { list in
                TodoView(item: list).onTapGesture {
                    self.listener?.push(view: TodoListView(item: list))
                }
            }
        }
        }.onAppear {
            self.model.loadLists()
        }
    }
}

struct TasksListView_Previews: PreviewProvider {
    static var previews: some View {
        TasksListView()
    }
}
