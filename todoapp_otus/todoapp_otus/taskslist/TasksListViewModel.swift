//
//  TasksListViewModel.swift
//  todoapp_otus
//
//  Created by Anna Zharkova on 10.05.2022.
//

import Foundation
import SwiftUI

class TasksListViewModel : ObservableObject {
    @Published var lists: [TasksList] = [TasksList]()
    
    func loadLists() {
        TasksManager.shared.load { [weak self] result in
            guard let self = self else {return}
            
            self.lists = [TasksList]()
            self.lists.append(contentsOf: result)
        }
    }
}
