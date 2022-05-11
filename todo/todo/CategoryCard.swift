//
//  CategoryCard.swift
//  ToFu
//
//  Created by Bri on 2/2/22.
//

import SwiftUI

struct CategoryCard: View {
    @State var item: TasksList
    var onAdd: (()->Void)? = nil
    
    var items: [TaskItem] {
        return item.tasks
    }
    
    var body: some View {
        Section {
            HStack {
                Text(item.title)
                    .font(.headline.bold())
                    .foregroundColor(.white)
                    .tint(.white)
                    .colorMultiply(.white)
                Spacer()
                Text(item.completedText)
                    .font(.callout)
                    .foregroundColor(.white)
                    .tint(.white)
                    .colorMultiply(.white)
            }
            .listRowBackground(Color.orange)
            
            ForEach(items) { item in
                ItemRow(task: item)
            }
            Text("Add task +").foregroundColor(.gray).frame(height: 40).onTapGesture {
                onAdd?()
            }
        }
        .animation(.spring(), value: item.tasks)
    }
}
