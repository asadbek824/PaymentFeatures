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

public struct PayShareView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject private var vm: PayShareViewModel
    
    public init(senderModel: SenderModel) {
        _vm = StateObject(wrappedValue: PayShareViewModel(senderModel: senderModel))
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
            NavigationStack {
                TransferView(
                    receiverModel: vm.receiverModel,
                    senderModel: vm.senderModel
                )
            }
        }
        .onAppear {
            vm.onAppear()
        }
        .overlay(alignment: .bottom, content: {
            CardSelectView()
        })
    }
    
    @ViewBuilder
    private func DiscoveredTargetsView() -> some View {
        if let peers = vm.multipeerService?.discoveredPeers, !peers.isEmpty {
            HStack(spacing: 16) {
                ForEach(peers) { peer in
                    RadarTargetView(title: peer.name)
                        .onTapGesture {
                            vm.connect(to: peer)
                            vm.featchReceiverData()
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
            ForEach(vm.senderModel?.senderCards ?? [], id: \.cartId) { card in
                CardItemView(card: card)
                    .tag(card)
            }
            
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .frame(height: 145)
    }
}

//#Preview {
//    let card = UserCard(
//        cartId: 1,
//        balance: 820360.48,
//        expenses: 1200210.24,
//        cartNumber: "8600060905809696",
//        cartName: "Xalq Bank",
//        currency: "сум", image: "https://raw.githubusercontent.com/00020647/imagesForPayShare/refs/heads/main/cardBlue.jpg"
//    )
//    
//    let cards: [UserCard] = [
//        UserCard(
//            cartId: 1,
//            balance: 820360.48,
//            expenses: 1200210.24,
//            cartNumber: "8600060905809696",
//            cartName: "Xalq Bank",
//            currency: "сум", image: "https://raw.githubusercontent.com/00020647/imagesForPayShare/refs/heads/main/cardBlue.jpg"
//        ),
//        UserCard(
//            cartId: 2,
//            balance: 720360.48,
//            expenses: 1200210.24,
//            cartNumber: "8600060905809696",
//            cartName: "Xalq Bank",
//            currency: "сум", image: "https://raw.githubusercontent.com/00020647/imagesForPayShare/refs/heads/main/cardBlue.jpg"
//        ),
//        UserCard(
//            cartId: 3,
//            balance: 620360.48,
//            expenses: 1200210.24,
//            cartNumber: "8600060905809696",
//            cartName: "Xalq Bank",
//            currency: "сум", image: "https://raw.githubusercontent.com/00020647/imagesForPayShare/refs/heads/main/cardBlue.jpg"
//        )
//    ]
//    
//    NavigationView {
//        PayShareView(
//            senderModel: .init(
//                user: .init(id: 1, fullName: "Suxrob"),
//                senderCards: cards,
//                selectedCard: card
//            )
//        )
//    }
//}
