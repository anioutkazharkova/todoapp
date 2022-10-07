//
//  TodoWidget.swift
//  TodoWidget
//
//  Created by Anna Zharkova on 26.05.2022.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), item: TasksList(title: "Notes"))
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), item: TasksList(title: "Notes"))
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        var entries: [SimpleEntry] = []

        TasksManager.shared.load { lists in
            let entry = SimpleEntry(date: Date(), item: lists.first ?? TasksList(title: "Notes"))
            entries.append(entry)
            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)
            WidgetCenter.shared.reloadAllTimelines()
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    
    let item: TasksList
}

struct TodoWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        Text(entry.date, style: .time)
    }
}

struct TodoWidget: Widget {
    let kind: String = "TodoWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            TodoWidgetView(entry: entry)
        }
        .supportedFamilies([.systemLarge, .systemSmall])
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

@main
struct TodoWidgetBundle : WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        TodoWidget()
        
    }
}

struct TodoWidget_Previews: PreviewProvider {
    static var previews: some View {
        TodoWidgetEntryView(entry: SimpleEntry(date: Date(), item: TasksList(title: "Notes")))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
