//
//  LockScreenWidgetView.swift
//  PaymeFituares
//
//  Created by Asadbek Yoldoshev on 4/11/25.
//

import SwiftUI

struct LockScreen_WidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        Link(destination: URL(string: "paymeFeature2://pay-share")!) {
            ZStack {
                Circle()
                    .strokeBorder(Color.white.opacity(0.3), lineWidth: 2)
                    .background(Circle().fill(Color.white.opacity(0.15)))
                Image(.payShareLogo)
                    .resizable()
                    .scaledToFit()
                    .padding(8)
            }
        }
    }
}
