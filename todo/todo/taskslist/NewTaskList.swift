//
//  NewTaskList.swift
//  todoapp_otus
//
//  Created by Anna Zharkova on 11.05.2022.
//

import SwiftUI
import SwiftUINavigator

struct NewTaskList: View, IItemView {
    var listener: INavigationContainer?
    
    @State private var date: Date = Date()
    @State private var hasDueDate: Bool = false
    @State private var taskListName: String = ""
    @State private var isEditing: Bool = false
    var body: some View {
        VStack {
            Spacer()
            
            VStack(alignment: .leading){
                HStack {
                    Text("Add new task list")
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    
                    Button(action: {
                        self.listener?.pop()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title3)
                    }
                }
                
                TextField("New Task Description", text: self.$taskListName, onEditingChanged: {
                    self.isEditing = $0
                })
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.bottom)
                
               
                Toggle("Has due date", isOn: $hasDueDate)
                if (hasDueDate) {
                    DatePicker("Date", selection: $date, displayedComponents: [.hourAndMinute, .date])
                        .datePickerStyle(.graphical)
                }
                
                Button(action: {
                    guard self.taskListName.trimmingCharacters(in: .whitespaces) != "" else {
                        return
                    }
                    
                    self.addNewTask()
                }){
                    Text("Add new TasksList")
                        .font(.system( .title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .background(.blue)
                        .frame(maxWidth: .infinity)
                }
                .cornerRadius(10)
                .padding(.vertical)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10, antialiased: true)
            //.offset(y: self.isEditing ? -320 : 0)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
    private func addNewTask() {
        var task = TasksList(title: self.taskListName)
        if hasDueDate {
            task.dueDate = date
        }
        TasksManager.shared.add(list: task) {
        self.listener?.pop()
        }
    }
}
