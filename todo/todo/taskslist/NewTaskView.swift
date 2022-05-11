//
//  NewTaskView.swift
//  todoapp_otus
//
//  Created by Anna Zharkova on 11.05.2022.
//

import SwiftUI
import SwiftUINavigator


struct NewTaskView: View, IItemView {
    var listener: INavigationContainer?
    @FocusState var focused
    
    @State var listId: UUID
    @State private var date: Date = Date()
    @State private var hasDueDate: Bool = false
    @State private var taskName: String = ""
    @State private var taskPriority: Priority = .normal
    @State private var isEditing: Bool = false
    @State private var taskDescription: String = ""
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Add new task")
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.bold)
                
                Spacer()
                
                
                Button(action: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        
                        self.listener?.pop()
                    }
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title3)
                        .foregroundColor(self.taskPriority.priorityColor())
                }
            }.padding(.horizontal)
            ScrollView {
            VStack(alignment: .leading){
                
                   
                
                TextField("New Task name", text: self.$taskName, onEditingChanged: {
                    self.isEditing = $0
                })
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.bottom)
                ItemDescriptionTextEditor(description: $taskDescription)
                    .focused($focused)
                Text("Priority")
                    .fontWeight(.semibold)
                
                HStack {
                    PriorityView(priority: .high, selectedPriority: self.$taskPriority)
                        .onTapGesture {
                            self.taskPriority = .high
                        }
                    
                    PriorityView(priority: .normal, selectedPriority: self.$taskPriority)
                        .onTapGesture {
                            self.taskPriority = .normal
                        }
                    
                    PriorityView(priority: .low, selectedPriority: self.$taskPriority)
                        .onTapGesture {
                            self.taskPriority = .low
                        }
                }
                Toggle("Has due date", isOn: $hasDueDate)
                if (hasDueDate) {
                    DatePicker("Date", selection: $date, displayedComponents: [.hourAndMinute, .date])
                        .datePickerStyle(.graphical)
                }
                
                Button(action: {
                    guard self.taskName.trimmingCharacters(in: .whitespaces) != "" else {
                        return
                    }
                    
                    self.addNewTask()
                }){
                    Text("Add new Task")
                        .font(.system( .title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(self.taskPriority.priorityColor())
                }
                .cornerRadius(10)
                .padding(.vertical)
                Spacer()
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10, antialiased: true)
            }
            //.offset(y: self.isEditing ? -200 : 0)
        }
    }
    
    private func addNewTask() {
        var task = TaskItem(title: self.taskName, description: self.taskDescription, listId: listId)
        if hasDueDate {
            task.dueDate = date
        }
        task.priority = self.taskPriority
        TasksManager.shared.saveTask(item: task) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                
                self.listener?.pop()
            }
        }
        }
}
