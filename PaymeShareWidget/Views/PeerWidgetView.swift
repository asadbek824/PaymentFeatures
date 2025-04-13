//
//  PeerWidgetView.swift
//  PaymeFituares
//
//  Created by Asadbek Yoldoshev on 4/11/25.
//

import SwiftUI
import AppIntents

struct PeerWidgetEntryView: View {
    let entry: PeerWidgetEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Близкие контакты")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)

                Spacer()

                Button(intent: RefreshPeersIntent()) {
                    ZStack {
                        Circle()
                            .fill(Color.white.opacity(0.2))
                            .frame(width: 32, height: 32)
                        Image(systemName: "arrow.clockwise")
                            .foregroundColor(.white)
                    }
                }
            }

            if entry.peerNames.isEmpty {
                Text("Никого рядом не обнаружено")
                    .foregroundColor(.white.opacity(0.7))
            } else {
                HStack(spacing: 16) {
                    ForEach(entry.peerNames.prefix(3), id: \.self) { peer in
                        VStack(spacing: 4) {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 36, height: 36)
                                .foregroundColor(.white)

                            Text(peer)
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(.white)
                                .lineLimit(1)
                        }
                        .frame(width: 64)
                        .padding(8)
                        .background(Color.white.opacity(0.15))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
            }

            HStack(spacing: 4) {
                Image(systemName: "info.circle")
                    .foregroundColor(.white.opacity(0.6))
                    .font(.caption2)
                Text("Обновлено: \(entry.date.formatted(.dateTime.hour().minute()))")
                    .font(.caption2)
                    .foregroundColor(.white.opacity(0.6))
            }
        }
        .padding(.horizontal, 12)
    }
}
