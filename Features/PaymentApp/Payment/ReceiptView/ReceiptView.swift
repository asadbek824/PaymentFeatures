//
//  ReceiptView.swift
//  Payment
//
//  Created by Akbarshah Jumanazarov on 4/7/25.
//

import Core
import SwiftUI

struct ReceiptView: View {
    
    var type: ReceiptType
    var peerMessage: PeerMessage
    @Binding var show: Bool
    
    var body: some View {
        VStack {
            VStack {
                Image(systemName: "checkmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .padding()
                    .foregroundStyle(.white)
                    .background(.green.gradient)
                    .clipShape(.circle)
                    .transition(.opacity.combined(with: .scale))
                
                Text(type == .sent ? "Sent" : "Received")
                    .font(.system(size: 35, weight: .bold))
                
                Button {
                    show.toggle()
                } label: {
                    Text("OK")
                        .padding()
                        .fontWeight(.medium)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .background(.appPrimary)
                        .clipShape(.rect(cornerRadius: 8))
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.yellow)
            .clipShape(.rect(cornerRadius: 16))
        }
        .padding()
        .fillSuperview()
        .background(.systemBackground.opacity(0.1))
        .animation(.smooth, value: show)
        .onTapGesture {
            show.toggle()
        }
    }
}
