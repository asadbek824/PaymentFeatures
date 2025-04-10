//
//  PayShareView.swift
//  Payment
//
//  Created by Akbarshah Jumanazarov on 4/4/25.
//

import Core
import AssetsKit
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
                .onTapGesture {
                    AppNavigationCoordinator.shared.navigate(to: .payments)
                }
        }
        .overlay(alignment: .top) {
            DiscoveredTargetsView()
                .id(vm.multipeerService?.discoveredPeers.count)
        }
        .backButton { dismiss() }
        .fillSuperview()
        .navigationTitle("Pay Share")
        .navigationBarTitleDisplayMode(.inline)
        .background(.secondarySystemBackground)
        .onDisappear {
            vm.stopSearching()
        }
        .sheet(isPresented: $vm.showSheet) {
            vm.disconnect()
        } content: {
            PayShareSheet(vm: vm)
                .presentationDetents([.medium])
        }
        .alert(item: $vm.receivedMessage) { message in
            Alert(
                title: Text("Received \(message.text) from \(message.sender)"),
                dismissButton: .cancel(Text("OK"))
            )
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
                        }
                }
            }
            .padding()
            .padding(.top, .screenWidth / 4)
            .frame(maxWidth: .infinity)
        }
    }
}

struct PayShareSheet: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var amount = ""
    @ObservedObject var vm: PayShareViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 12) {
                VStack {
                    Text("Получатель:")
                        .padding(.leading)
                        .font(.caption2)
                        .foregroundStyle(.secondaryLabel)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack(spacing: 16) {
                        Image(systemName: "person")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .frame(width: 60, height: 60)
                            .foregroundStyle(.secondaryLabel)
                            .background(.secondarySystemBackground)
                            .clipShape(.circle)
                        
                        Text(vm.connectedPeer?.name ?? "Неизвестный")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.systemBackground)
                    .clipShape(.rect(cornerRadius: 12))
                }
                
                HStack {
                    TextField("Введите сумму", text: $amount)
                        .keyboardType(.numberPad)
                    
                    Image(systemName: "creditcard")
                }
                .padding()
                .background(.systemBackground)
                .clipShape(.rect(cornerRadius: 12))
                
                Spacer()
            }
            .padding()
            .navigationTitle("Детали трансфера")
            .navigationBarTitleDisplayMode(.inline)
            .fillSuperview()
            .background(.secondarySystemBackground)
            .safeAreaInset(edge: .bottom, content: BottomInset)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Отмена") {
                        vm.disconnect()
                        dismiss()
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func BottomInset() -> some View {
        Button {
            if vm.sendMessage(amount) == true {
                dismiss()
            }
        } label: {
            Text("Отправить")
                .padding()
                .frame(maxWidth: .infinity)
                .foregroundStyle(.white)
                .fontWeight(.medium)
                .background(.appPrimary)
                .clipShape(.rect(cornerRadius: 12))
        }
        .padding()
    }
}

#Preview {
    NavigationView {
        PayShareView()
    }
}
