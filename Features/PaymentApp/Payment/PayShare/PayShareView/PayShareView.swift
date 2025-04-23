//
//  PayShareView.swift
//  Payment
//
//  Created by Akbarshah Jumanazarov on 4/4/25.
//

import SwiftUI
import DesignSystem
import SharedUI
import Core
import NavigationCoordinator

public struct PayShareView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject private var vm: PayShareViewModel
    
    public init(senderModel: SenderModel, source: NavigationSource, navigationCoordinator: AppNavigationCoordinator) {
        _vm = StateObject(wrappedValue: PayShareViewModel(senderModel: senderModel, source: source, navigationCoordinator: navigationCoordinator))
    }
    
    public var body: some View {
        ZStack {
            RadarView()
            
            Image(uiImage: AssetsKitDummy.Image.payshare)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .screenWidth / 4, maxHeight: .screenWidth / 4)
                .clipShape(.circle)
        }
        .overlay(alignment: .top) {
            VStack {
                InfoPane()
                DiscoveredTargetsView()
                    .id(vm.discoveredPeers.count)
            }
        }
        .backButton {
            vm.stop()
            dismiss()
        }
        .fillSuperview()
        .navigationTitle("PayShare")
        .navigationBarTitleDisplayMode(.inline)
        .frame(maxWidth: .screenWidth)
        .background(.secondarySystemBackground)
        .animation(.bouncy, value: vm.discoveredPeers)
        .onAppear(perform: vm.start)
        .overlay(alignment: .bottom, content: CardSelectView)
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("TRANSFER"))) { notification in
            if let amount = notification.userInfo?["amount"] as? String {
                vm.sendMessage(amount)
            }
        }
    }
    
    @ViewBuilder
    private func DiscoveredTargetsView() -> some View {
        if vm.discoveredPeers.count > 0 {
            HStack(spacing: 16) {
                ForEach(vm.discoveredPeers) { peer in
                    RadarTargetView(title: peer.name)
                        .onTapGesture {
                            vm.connectToPeer(peer)
                        }
                        .transition(.scale)
                        .shadow(radius: 5)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
    }

    
    @ViewBuilder
    private func CardSelectView() -> some View {
        TabView(selection: $vm.selectedCard) {
            ForEach(vm.senderModel?.senderCards ?? [], id: \.cartId) { card in
                CardItemView(card: card)
                    .tag(card)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .frame(height: 145)
    }
    
    @ViewBuilder
    private func InfoPane() -> some View {
        HStack {
            Text("Убедитесь, что у другого пользователя также открыт экран Pay Share.")
                .font(.callout)
                .foregroundStyle(.secondaryLabel)
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .setStroke(color: .secondaryLabel, cornerRadius: 12)
        .padding()
    }
}
