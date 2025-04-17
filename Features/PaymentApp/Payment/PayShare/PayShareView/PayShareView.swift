//
//  PayShareView.swift
//  Payment
//
//  Created by Akbarshah Jumanazarov on 4/4/25.
//

//import NavigationCoordinator
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
            TransferView(receiverModel: vm.receiverModel, senderModel: vm.senderModel)
        }
        .onAppear {
            vm.onAppear()
        }
        
    }
    
    @ViewBuilder
    private func DiscoveredTargetsView() -> some View {
        if let peers = vm.multipeerService?.discoveredPeers, peers.count > 0 {
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
}

//#Preview {
//    NavigationView {
//        PayShareView()
//    }
//}
