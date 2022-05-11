//
//  TodoItemView.swift
//  todo
//
//  Created by Anna Zharkova on 11.05.2022.
//

import SwiftUI

struct TodoItemView: View {
    @State var item: TasksList
    
    var body: some View {
    Section {
        VStack(alignment: .leading) {
            Text(item.title)
                .font(.headline.bold())
                .foregroundColor(.white)
                .tint(.white)
                .colorMultiply(.white)
            VStack(alignment: .leading){
            ForEach(item.tasks.prefix(3).indices, id: \.self) { index in
                let task = item.tasks[index]
                TaskRow(item: task).listRowInsets(EdgeInsets())
            }
            if item.tasks.count > 3 {
                Text("Show more...").foregroundColor(.white)
            }
            Text("Click to add...")
            }.background(.white).frame(maxWidth: .infinity)
        }.padding(.zero)
        
        .animation(.spring(), value: item.tasks)
    }.padding(.zero).listRowBackground(Color.accentColor)
    
    }
}
