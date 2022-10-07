//
//  TodoWidgetView.swift
//  TodoWidgetExtension
//
//  Created by Anna Zharkova on 26.05.2022.
//

import SwiftUI

struct TodoWidgetView : View {
    @Environment(\.widgetFamily) var family
    var entry: Provider.Entry
    
    var body: some View {
        switch family {
        case .systemSmall:
            TodoWidgetSmallView(entry: entry)
        case .systemLarge:
            TodoWidgetLargeView(entry: entry)
        default:
            Text("Not supported")
        }
    }
}

struct TodoWidgetLargeView: View {
    var entry: Provider.Entry
    
        
        var body: some View {
            VStack(alignment: .leading) {
                HStack {
                    Text(entry.item.title)
                        .font(.headline.bold())
                        .foregroundColor(.white)
                        .tint(.white)
                        .colorMultiply(.white)
                    Spacer()
                    Text(entry.item.completedText)
                        .font(.callout)
                        .foregroundColor(.white)
                        .tint(.white)
                        .colorMultiply(.white)
                }.padding(.horizontal).frame(maxWidth: .infinity , minHeight: 40).background(Color.orange)
                VStack(alignment: .leading) {
                    ForEach(entry.item.tasks.prefix(3)) { item in
                   SimpleRow(task: item)
                   Divider()
                }
                Text("Add task +").foregroundColor(.gray).frame(height: 40)
                }.padding()
                Spacer()
            }
            }
        }
