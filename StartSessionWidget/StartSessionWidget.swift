//
//  StartSessionWidget.swift
//  StartSessionWidget
//
//  Created by Jannis Gehring on 08.05.24.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        let date = Date()
        return SimpleEntry(date: date, hoursToGo: computeHoursToGo(time: date))
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let date = Date()
        let entry = SimpleEntry(date: date, hoursToGo: computeHoursToGo(time: date))
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let date = Date()
        for hourOffset in 0 ..< 5 {
            let cal = Calendar.current
            
            let time = cal.date(byAdding: .hour, value: hourOffset, to: date)!
            
            let hoursToGo = computeHoursToGo(time: time)
          
            let minutes = cal.component(.minute, from: date)
            let seconds = cal.component(.second, from: date)
            
            let fullHourDate = date - TimeInterval(minutes*60) - TimeInterval(seconds)
            
            let entry = SimpleEntry(date: fullHourDate, hoursToGo: hoursToGo)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    func computeHoursToGo(time: Date) -> Int {
        
        let lastHour = Calendar.current.component(.hour, from: time)
        let hoursToGo = 23 - lastHour
        
        return hoursToGo
    }
}

struct SimpleEntry: TimelineEntry {
    var date: Date
    var hoursToGo: Int
}

struct StartSessionWidgetEntryView : View {
    var entry: Provider.Entry
    
    @Environment(\.widgetFamily) var family
    
    let startSession: URL = URL(string: "startSession")!
    
    var body: some View {
        switch family {
        case .systemSmall:
            SystemSmallWidgetView()
                .widgetURL(startSession)
        case .systemMedium:
            SystemMediumWidgetView(hoursToGo: entry.hoursToGo)
        case .accessoryCircular:
            AccessoryCircularWidget()
                .widgetURL(startSession)
        case .accessoryRectangular:
            AccessoryRectangularWidget()
                .widgetURL(startSession)
        default:
            SystemSmallWidgetView()
                .widgetURL(startSession)
        }
        
    }
}

struct StartSessionWidget: Widget {
    let kind: String = "StartSessionWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                StartSessionWidgetEntryView(entry: entry)
                    .containerBackground(.background.tertiary, for: .widget)
            } else {
                StartSessionWidgetEntryView(entry: entry)
                    .background()
            }
        }
        .configurationDisplayName("New session")
        .description("Quickly start a new session from your homescreen!")
        .supportedFamilies([.systemSmall, .systemMedium, .accessoryInline, .accessoryCircular, .accessoryRectangular])
    }
}

#Preview(as: .systemSmall) {
    StartSessionWidget()
} timeline: {
    SimpleEntry(date: .now, hoursToGo: 2)
    SimpleEntry(date: .now, hoursToGo: 23)
}
#Preview(as: .accessoryCircular) {
    StartSessionWidget()
} timeline: {
    SimpleEntry(date: .now, hoursToGo: 2)
    SimpleEntry(date: .now, hoursToGo: 23)
}
#Preview(as: .accessoryRectangular) {
    StartSessionWidget()
} timeline: {
    SimpleEntry(date: .now, hoursToGo: 2)
    SimpleEntry(date: .now, hoursToGo: 23)
}
