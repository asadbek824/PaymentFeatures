//
//  LockScreenWidgetView.swift
//  PaymeFituares
//
//  Created by Asadbek Yoldoshev on 4/11/25.
//

import SwiftUI

struct LockScreenWidgetView: View {
    var entry: LockScreenProvider.Entry

    var body: some View {
        Link(destination: URL(string: "paymeFeature2://pay-share")!) {
            ZStack {
                Circle()
                    .strokeBorder(Color.white.opacity(0.3), lineWidth: 2)
                    .background(Circle().fill(Color.white.opacity(0.15)))

                VStack(spacing: 2) {
                    Text("Pay")
                        .font(.caption2)
                        .bold()
                    Text("Share")
                        .font(.caption2)
                }
                .foregroundColor(.white)
            }
        }
    }
}
