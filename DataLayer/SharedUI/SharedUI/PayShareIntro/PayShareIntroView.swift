//
//  PayShareIntroView.swift
//  Payment
//
//  Created by Akbarshah Jumanazarov on 4/10/25.
//

import Core
import DesignSystem
import SwiftUI

public struct PayShareIntroView: View {
    
    public init() { }
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                logo
                
                Text("Pay Share - это:")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(spacing: 24) {
                    ForEach(PayShareIntroConstants.content) { content in
                        paragraph(title: content.title, icon: content.icon)
                    }
                }
            }
            .padding()
        }
        .clipped()
        .scrollIndicators(.hidden)
        .navigationTitle("Что такое Pay Share?")
        .navigationBarTitleDisplayMode(.inline)
        .fillSuperview()
        .background(.secondarySystemBackground)
        .safeAreaInset(edge: .bottom, content: BottomButtons)
    }
}

// MARK: - ViewBuilders
private extension PayShareIntroView {
    @ViewBuilder
    private var logo: some View {
        ZStack {
            ForEach([90, 60, 30, 0], id: \.self) { offset in
                Circle()
                    .fill(.appPrimary.opacity(offset == 0 ? 1 : 0.2 + Double(90 - offset) / 300))
                    .frame(maxWidth: .screenWidth / 3 + CGFloat(offset),
                          maxHeight: .screenWidth / 3 + CGFloat(offset))
            }
            
            Image(uiImage: AssetsKitDummy.Image.payshare)
                .resizable()
                .scaledToFit()
                .clipShape(.circle)
                .frame(maxWidth: .screenWidth / 3, maxHeight: .screenWidth / 3)
        }
        .frame(maxWidth: .screenWidth)
    }
    
    @ViewBuilder
    private func paragraph(title: String, icon: UIImage) -> some View {
        HStack(spacing: 5) {
            Image(uiImage: icon)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 40, maxHeight: 40)
            
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
                .font(.body)
                .fontWeight(.semibold)
        }
    }
    
    @ViewBuilder
    private func BottomButtons() -> some View {
        VStack {
            actionButton(title: "Попробовать", style: .primary)
            actionButton(title: "Пропустить", style: .secondary)
        }
        .padding([.horizontal, .bottom])
    }
    
    @ViewBuilder
    private func actionButton(title: String, style: ButtonStyle) -> some View {
        Button {
            // Action handled by coordinator
        } label: {
            Text(title)
                .padding()
                .fontWeight(.medium)
                .frame(maxWidth: .infinity)
                .foregroundStyle(style.foreground)
                .background(style.background)
                .clipShape(.rect(cornerRadius: 12))
        }
    }
}

// MARK: - Button Style
private extension PayShareIntroView {
    enum ButtonStyle {
        case primary
        case secondary
        
        var background: Color {
            switch self {
            case .primary: return .appPrimary
            case .secondary: return .appPrimary.opacity(0.15)
            }
        }
        
        var foreground: Color {
            switch self {
            case .primary: return .white
            case .secondary: return .appPrimary
            }
        }
    }
}

#Preview {
    VStack {
        //
    }
    .padding()
    .fillSuperview()
    .background(.black)
    .sheet(isPresented: .constant(true)) {
        PayShareIntroView()
            .interactiveDismissDisabled()
    }
}
