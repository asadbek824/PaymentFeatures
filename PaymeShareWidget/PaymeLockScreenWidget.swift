//
//  PaymeLockScreenWidget.swift
//  PaymeShareWidgetExtension
//
//  Created by Akbarshah Jumanazarov on 4/9/25.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        var entries: [SimpleEntry] = []
        let currentDate = Date()

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
}

struct LockScreen_WidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        Link(destination: URL(string: "paymeFeature2://pay-share")!) {
            Image(.payShareLockScreen)
                .resizable()
                .scaledToFit()
                .clipShape(.circle)
        }
    }
}

struct PaymeLockScreenWidget: Widget {
    let kind: String = "LockScreen_Widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            LockScreen_WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Pay Share")
        .description("Payme Pay Share feature widget.")
        .supportedFamilies([.accessoryCircular])
    }
}

#Preview(as: .accessoryCircular) {
    PaymeLockScreenWidget()
} timeline: {
    SimpleEntry(date: .now)
}

