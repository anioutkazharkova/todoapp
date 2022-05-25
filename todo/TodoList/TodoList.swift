//
//  TodoList.swift
//  TodoList
//
//  Created by Anna Zharkova on 12.05.2022.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: .now, item: TasksList(title: "Notes"))
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        TasksManager.shared.load { lists in
            if !lists.isEmpty {
            let entry = SimpleEntry(date: Date(), item: lists[0])
             completion(entry)
            } else {
                completion(SimpleEntry(date: .now, item: TasksList(title: "Notes")))
            }
            WidgetCenter.shared.reloadAllTimelines()

        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        TasksManager.shared.load { lists in
            if !lists.isEmpty {
                let entry = SimpleEntry(date: .now, item: lists[0])
                let timeline = Timeline(entries: [entry], policy: .atEnd)
                completion(timeline)
                
            } else {
                let entry = SimpleEntry(date: .now, item: TasksList(title: "Same"))
                let timeline = Timeline(entries: [entry], policy: .atEnd)
                completion(timeline)
            }
        }
    }
}

struct SimpleEntry: TimelineEntry {
    var date: Date
    
    let item: TasksList
    
    var relevance: TimelineEntryRelevance? {
        return TimelineEntryRelevance(score: 100)
    }
}


@main
struct TodoList: Widget {
    let kind: String = "TodoList"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            TodoListEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}
