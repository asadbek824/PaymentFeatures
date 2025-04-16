//
//  PayShareView.swift
//  Payment
//
//  Created by Akbarshah Jumanazarov on 4/4/25.
//

import Core
import NavigationCoordinator
import SwiftUI

public struct PayShareView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject private var vm = PayShareViewModel()
    
    public init() {  }
    
    public var body: some View {
        ZStack {
            RadarView()
            
            Image(uiImage: Asset.Image.payshare)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .screenWidth / 4, maxHeight: .screenWidth / 4)
                .clipShape(.circle)
        }
        .overlay(alignment: .top) {
            DiscoveredTargetsView()
                .id(vm.multipeerService?.discoveredPeers.count)
        }
        .backButton {
            dismiss()
        }
        .fillSuperview()
        .navigationTitle("Pay Share")
        .navigationBarTitleDisplayMode(.inline)
        .background(.secondarySystemBackground)
        .onDisappear {
            vm.stopSearching()
            vm.disconnect()
        }
        .fullScreenCover(isPresented: $vm.showSheet) {
            vm.disconnect()
        } content: {
            TransferView(card: vm.selectedCard)
        }
        .overlay(alignment: .bottom, content: {
            CardSelectView()
        })
    }
    
    @ViewBuilder
    private func DiscoveredTargetsView() -> some View {
        if let peers = vm.multipeerService?.discoveredPeers, peers.count > 0 {
            HStack(spacing: 16) {
                ForEach(peers) { peer in
                    RadarTargetView(title: peer.name)
                        .onTapGesture {
                            vm.connect(to: peer)
                        }
                }
            }
            .padding()
            .padding(.top, .screenWidth / 4)
            .frame(maxWidth: .infinity)
        }
    }
    
    @ViewBuilder
    private func CardSelectView() -> some View {
        TabView(selection: $vm.selectedCard) {
            ForEach(PreviewData.cards) { card in
                CardItemView(card: card)
                    .tag(card)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .frame(height: 145)
    }
    
    private struct CardItemView: View {
        let card: UserCard
        
        var body: some View {
            HStack {
                // Left column: Card info text
                VStack(alignment: .leading, spacing: 8) {
                    Text(card.cartName)
                        .font(.headline)
                        .foregroundColor(.white)
                    Text("Баланс: \(card.balance, specifier: "%.0f") \(card.currency)")
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
                Spacer()
                // Right column: Masked card number
                VStack(alignment: .trailing) {
                    Text("**** \(card.cartNumber.suffix(4))")
                        .font(.system(.callout, design: .monospaced))
                        .foregroundColor(.white)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, minHeight: 100)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        PreviewData.color(for: card).opacity(0.7),
                        PreviewData.color(for: card)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .cornerRadius(12)
            )
            .padding(.horizontal)
            .padding(.bottom, 40)
        }
    }
}

#Preview {
    NavigationView {
        PayShareView()
    }
}
