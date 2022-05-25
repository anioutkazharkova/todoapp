//
//  TasksManager.swift
//  todoapp_otus
//
//  Created by Anna Zharkova on 10.05.2022.
//

import Foundation
import Foundation
import SwiftUI

class TasksStorage {
    static let shared = TasksStorage()
    
    private lazy var decoder: JSONDecoder = {
       return JSONDecoder()
    }()
    
    private lazy var encoder: JSONEncoder = {
        return JSONEncoder()
    }()
    
    private func fileURL() throws -> URL? {
         FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.ru.azharkova.todo.TodoList")?
            .appendingPathComponent("tasksapp.data")
    }
    
    func load(completion: @escaping (Result<[TasksList], Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                guard let fileURL = try? self.fileURL() else {
                    return
                }
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                let tasks = try self.decoder.decode([TasksList].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(tasks))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func save(scrums: [TasksList], completion: @escaping (Result<Int, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try self.encoder.encode(scrums)
                guard let outfile = try? self.fileURL() else {
                    return
                }
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(scrums.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
