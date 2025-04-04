//
//  PayShareView.swift
//  Payment
//
//  Created by Akbarshah Jumanazarov on 4/4/25.
//

import Core
import SwiftUI

struct PayShareView: View {
    
    @StateObject private var vm = PayShareViewModel()
    
    var body: some View {
        VStack {
            GeometryReader {
                let size = $0.size
                
                ZStack {
                    RadarView()
                    RadarTargetView(title: "Me")
                }
                .frame(width: size.width, height: size.height)
            }
            .overlay(alignment: .top) {
                DiscoveredTargetsView()
            }
        }
        .backButton()
        .fillSuperview()
        .navigationTitle("Pay Share")
        .navigationBarTitleDisplayMode(.inline)
        .background(.secondarySystemBackground)
        .sheet(isPresented: $vm.showSheet) {
            Text("dfsdf")
                .presentationDetents([.medium])
        }
    }
    
    @ViewBuilder
    private func DiscoveredTargetsView() -> some View {
        HStack(spacing: 16) {
            ForEach(vm.multipeerService.discoveredPeers) { device in
                RadarTargetView(title: device.name)
                    .onTapGesture {
                        vm.connect(to: device)
                    }
            }
        }
        .padding()
        .padding(.top, .screenWidth / 4)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    NavigationView {
        PayShareView()
    }
}
