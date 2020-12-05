//
//  WeatherAppWidget.swift
//  WeatherAppWidget
//
//  Created by sameh on 12/5/20.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), temp: "")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), temp: "")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        let entryData = UserDefaults(suiteName: "WeatherApp")!.string(forKey: "temp") ?? ""
        let entry = SimpleEntry(date: Date(), temp: entryData)
        entries.append(entry)

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    var date: Date
    
    let temp: String
}

struct WeatherAppWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        Text(entry.temp + " " + "\(entry.date)")
    }
}



@main
struct WeatherAppWidget: Widget {
    let kind: String = "WeatherAppWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WeatherAppWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct WeatherAppWidget_Previews: PreviewProvider {
    static var previews: some View {
        WeatherAppWidgetEntryView(entry: SimpleEntry(date: Date(), temp: ""))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
