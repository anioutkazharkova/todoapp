//
//  TasksManager.swift
//  todoapp_otus
//
//  Created by Anna Zharkova on 10.05.2022.
//

import Foundation

class TasksManager {
    static let shared = TasksManager()
    
    private lazy var storage: TasksStorage = {
       return TasksStorage()
    }()
    
    func save(list: TasksList) {
        storage.load { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let data):
                if let index = data.firstIndex(where: {$0.id == list.id}) {
                    var newData = data.map{$0}
                    newData[index] = list
                    self.storage.save(scrums: newData) {_ in
                        
                    }
                } else {
                    self.storage.save(scrums: [list]) { result in
                        
                    }
                }
            default:
                break
            }
        }
    }
    
    func add(list: TasksList, completion: @escaping()->Void) {
        storage.load { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let data):
               var lists = data
                lists.append(list)
                self.storage.save(scrums: lists, completion: {_ in completion()})
            default:
                break
            }
        }
    }
    
    func load(completion: @escaping([TasksList])->Void) {
        self.storage.load { result in
            switch result {
            case .success(let data):
                completion(data)
            default:
                break
            }
        }
    }
    
    func load(id: UUID, completion: @escaping(TasksList?)->Void) {
        self.storage.load { result in
            switch result {
            case .success(let data):
                completion(data.filter({$0.id == id}).first)
            default:
                break
            }
        }
    }
    
    func change(item: TaskItem) {
        self.load { lists in
            var newLists = lists.map{$0}
            if let listIndex = lists.firstIndex(where: {$0.id == item.listId}) {
                if let index = lists[listIndex].tasks.firstIndex(where: {$0.id == item.id}) {
                    newLists[listIndex].tasks[index] = item
                    self.storage.save(scrums: newLists, completion: {_ in})
                }
            }
        }
    }
    
    func delete(item: TaskItem) {
        self.load { lists in
            var newLists = lists.map{$0}
            if let listIndex = lists.firstIndex(where: {$0.id == item.listId}) {
                if let index = lists[listIndex].tasks.firstIndex(where: {$0.id == item.id}) {
                    newLists[listIndex].tasks.remove(at: index)
                    self.storage.save(scrums: newLists, completion: {_ in})
                }
            }
        }
    }
    
    func saveTask(item: TaskItem, completion: @escaping()->Void) {
        self.load { lists in
            var newLists = lists.map{$0}
            if let listIndex = lists.firstIndex(where: {$0.id == item.listId}) {
                
                    newLists[listIndex].tasks.append(item)
                    self.storage.save(scrums: newLists, completion: {_ in
                        completion()
                    })
            }
        }
    }
}
