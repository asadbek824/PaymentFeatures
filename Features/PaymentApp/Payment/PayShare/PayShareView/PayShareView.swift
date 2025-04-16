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
        .safeAreaInset(edge: .bottom, content: CardSelectView)
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
                Text(card.cartName)
                    .tag(card)
                    .fillSuperview()
                    .background(Color.red)
                    .clipShape(.rect(cornerRadius: 12))
                    .border(.green)
                    .padding()
                    .padding(.bottom)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .frame(height: 100)
        .border(.red)
    }
}

#Preview {
    NavigationView {
        PayShareView()
    }
}
