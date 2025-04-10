//
//  PaymeLockScreenWidget.swift
//  PaymeShareWidgetExtension
//
//  Created by Akbarshah Jumanazarov on 4/9/25.
//

//import Core
import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        // For a static placeholder, we just provide the current date.
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        var entries: [SimpleEntry] = []
        let currentDate = Date()

        // Generate a timeline consisting of five entries one hour apart.
        for hourOffset in 0 ..< 5 {
            if let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate) {
                let entry = SimpleEntry(date: entryDate)
                entries.append(entry)
            }
        }
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    // No emoji or title properties needed since you'll use images.
}

struct LockScreen_WidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        Link(destination: URL(string: "paymeFeature2://pay-share")!) {
            ZStack {
                Image(systemName: "circle")
                    .resizable()
                    .scaledToFit()

                VStack {
                    Text("Pay")
                    Text("Share")
                }
                .font(.caption)
            }
        }
    }
}
struct PaymeLockScreenWidget: Widget {
    let kind: String = "LockScreen_Widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                LockScreen_WidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                LockScreen_WidgetEntryView(entry: entry)
                    .padding()
                    .background(Material.ultraThin)
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget showing images only.")
        .supportedFamilies([.accessoryCircular])
    }
}

// Preview for the circular widget.
#Preview(as: .accessoryCircular) {
    PaymeLockScreenWidget()
} timeline: {
    SimpleEntry(date: .now)
}

