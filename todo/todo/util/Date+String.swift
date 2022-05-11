//
//  Date+String.swift
//  todoapp_otus
//
//  Created by Anna Zharkova on 11.05.2022.
//

import Foundation

extension Date {
   func getFormattedDate(format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
