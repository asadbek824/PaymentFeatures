//
//  PaymeShareWidgetBundle.swift
//  PaymeFituares
//
//  Created by Asadbek Yoldoshev on 4/11/25.
//

import WidgetKit
import SwiftUI

@main
struct PaymeShareWidgetBundle: WidgetBundle {
    var body: some Widget {
        PeerWidget()
        PaymeLockScreenWidget()
    }
}
