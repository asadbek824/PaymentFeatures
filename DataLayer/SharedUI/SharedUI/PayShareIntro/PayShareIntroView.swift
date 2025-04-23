//
//  PayShareIntroView.swift
//  Payment
//
//  Created by Akbarshah Jumanazarov on 4/10/25.
//

import Core
import DesignSystem
import SwiftUI

struct PayShareIntoParagraphContent: Identifiable {
    let id = UUID()
    let title: String
    let description: String
}

public struct PayShareIntroView: View {
    
    @State private var selectedTabIndex: Int = 0
    
    private let content: [PayShareIntoParagraphContent] = [
        .init(title: "Новая функция перевода денег", description: "Отправляйте деньги без номера карты или телефона — просто откройте экран \"Pay Share\"."),
        .init(title: "Простота перевода", description: "Откройте приложение, попросите другого пользователя сделать то же самое, и когда он появится на \"радаре\", отправьте деньги."),
        .init(title: "Безопасность и удобство", description: "Не нужно запоминать номера карт или носить их с собой — всё безопасно и удобно!")
    ]
    
    public init() {  }
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Logo()
                
                Text("Pay Share - это:")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(spacing: 24) {
                    ForEach(content) { content in
                        Paragraph(title: content.title, description: content.description)
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
        .safeAreaInset(edge: .bottom, content: BottomInset)
    }
    
    @ViewBuilder
    private func Logo() -> some View {
        ZStack {
            Circle()
                .fill(.appPrimary.opacity(0.2))
                .frame(maxWidth: .screenWidth / 3 + 90, maxHeight: .screenWidth / 3 + 90)
            
            Circle()
                .fill(.appPrimary.opacity(0.4))
                .frame(maxWidth: .screenWidth / 3 + 60, maxHeight: .screenWidth / 3 + 60)
            
            Circle()
                .fill(.appPrimary.opacity(0.6))
            .frame(maxWidth: .screenWidth / 3 + 30, maxHeight: .screenWidth / 3 + 30)
            
            Image(uiImage: AssetsKitDummy.Image.payshare)
                .resizable()
                .scaledToFit()
                .clipShape(.circle)
                .frame(maxWidth: .screenWidth / 3, maxHeight: .screenWidth / 3)
        }
        .frame(maxWidth: .screenWidth)
    }
    
    @ViewBuilder
    private func Paragraph(title: String, description: String) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .padding(.leading)
                .font(.title3)
                .fontWeight(.semibold)
            
            Text(description)
                .font(.callout)
        }
    }
    
    @ViewBuilder
    private func TabContent(title: String, image: UIImage) -> some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                
            Text(title)
        }
    }
    
    @ViewBuilder
    private func BottomInset() -> some View {
        VStack {
            Button {
                //
            } label: {
                Text("Попробовать")
                    .padding()
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.white)
                    .background(.appPrimary)
                    .clipShape(.rect(cornerRadius: 12))
            }
            
            Button {
                //
            } label: {
                Text("Пропустить")
                    .padding()
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.appPrimary)
                    .background(.appPrimary.opacity(0.15))
                    .clipShape(.rect(cornerRadius: 12))
            }
        }
        .padding([.horizontal, .bottom])
    }
}

#Preview {
    VStack {
        
    }
    .padding()
    .fillSuperview()
    .background(.black)
    .sheet(isPresented: .constant(true)) {
        PayShareIntroView()
            .interactiveDismissDisabled()
    }
}
