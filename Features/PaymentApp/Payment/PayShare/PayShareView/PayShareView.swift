//
//  PayShareView.swift
//  Payment
//
//  Created by Akbarshah Jumanazarov on 4/4/25.
//

import SwiftUI
import Core

struct PayShareView: View {
    
    @StateObject private var vm = PayShareViewModel()
    
    var body: some View {
        VStack {
            if vm.isConnected {
                ConnectedView()
            } else {
                SearchingView()
            }
        }
        .fillSuperview()
        .navigationTitle("Pay Share")
        .navigationBarTitleDisplayMode(.inline)
        .background(.secondarySystemBackground)
        .backButton()
    }
    
    @ViewBuilder
    private func SearchingView() -> some View {
        GeometryReader {
            let size = $0.size
            ZStack {
                RadarView()
                RadarTargetView(title: "Me")
                    .scaleEffect(vm.isScaling ? 1.2 : 1.0)
                    .animation(
                        .easeInOut(duration: 1.2)
                        .repeatForever(autoreverses: true),
                        value: vm.isScaling
                    )
            }
            .frame(maxWidth: size.width, maxHeight: size.height)
        }
    }
    
    @ViewBuilder
    private func ConnectedView() -> some View {
        VStack {
            RadarTargetView(title: "Other")
            
            Rectangle()
                .fill(.secondaryLabel)
                .frame(width: 2, height: .screenWidth / 2)
                .overlay {
                    Image(systemName: "link.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(.appPrimary)
                        .background()
                        .clipShape(.circle)
                        .scaleEffect(vm.isScaling ? 1.2 : 1.0)
                        .animation(
                            .easeInOut(duration: 1.2)
                            .repeatForever(autoreverses: true),
                            value: vm.isScaling
                        )
                        .onAppear {
                            vm.isScaling = true
                        }
                }
                
            RadarTargetView(title: "Me")
                .padding(.top, -16)
        }
        .fillSuperview()
    }
}

#Preview {
    NavigationView {
        PayShareView()
    }
}
