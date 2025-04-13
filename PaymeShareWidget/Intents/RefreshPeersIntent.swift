//
//  RefreshPeersIntent.swift
//  PaymeFituares
//
//  Created by Asadbek Yoldoshev on 4/11/25.
//

import AppIntents
import WidgetKit
import Core

let appGroupID = "group.AssA.PaymeFituaresApp.PaymeShareWidget"

struct RefreshPeersIntent: AppIntent {
    static var title: LocalizedStringResource = "Обновить устройства поблизости"
    static var description = IntentDescription("Обновить Multipeer статус и перезапустить поиск")

    func perform() async throws -> some IntentResult {
        let defaults = UserDefaults(suiteName: appGroupID)
        defaults?.setValue("Searching...", forKey: "connectionStatus")
        defaults?.setValue([], forKey: "peerNames")
        
        WidgetCenter.shared.reloadAllTimelines()
        return .result()
    }
}
