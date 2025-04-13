//
//  LockScreenProvider.swift
//  PaymeFituares
//
//  Created by Asadbek Yoldoshev on 4/11/25.
//

import WidgetKit

struct LockScreenProvider: TimelineProvider {
    func placeholder(in context: Context) -> LockScreenEntry {
        LockScreenEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (LockScreenEntry) -> Void) {
        completion(LockScreenEntry(date: Date()))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<LockScreenEntry>) -> Void) {
        let currentDate = Date()
        let entries = (0..<5).compactMap { offset in
            Calendar.current.date(byAdding: .hour, value: offset, to: currentDate)
        }.map { LockScreenEntry(date: $0) }

        completion(Timeline(entries: entries, policy: .atEnd))
    }
}
