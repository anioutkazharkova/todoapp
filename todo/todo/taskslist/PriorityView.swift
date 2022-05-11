//
//  PriorityView.swift
//  todoapp_otus
//
//  Created by Anna Zharkova on 11.05.2022.
//

import SwiftUI

struct PriorityView: View {
    @State var priority: Priority
    @Binding var selectedPriority: Priority
    
    
    var body: some View {
        Text(priority.priorityType)
            .font(.system(.headline, design: .rounded))
            .foregroundColor(.white)
            .padding(10)
            .background(selectedPriority.priorityType == priority.priorityType ? selectedPriority.priorityColor(): Color(.systemGray4))
            .cornerRadius(10)
    }
}
