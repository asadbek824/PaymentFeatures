//
//  PayShareIntroView.swift
//  Payment
//
//  Created by Akbarshah Jumanazarov on 4/10/25.
//

import Core
import SwiftUI

struct PayShareIntroView: View {
    
    @State private var selectedTabIndex: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTabIndex) {
            
        }
        .tabViewStyle(.page)
        .padding()
        .fillSuperview()
        .background(.secondarySystemBackground)
        .safeAreaInset(edge: .bottom, content: BottomInset)
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
        Button {
            //
        } label: {
            Text("Next")
                .padding()
                .fontWeight(.medium)
                .frame(maxWidth: .infinity)
                .foregroundStyle(.white)
                .background(.appPrimary)
                .clipShape(.rect(cornerRadius: 12))
        }
        .padding()
    }
}

#Preview {
    PayShareIntroView()
}
