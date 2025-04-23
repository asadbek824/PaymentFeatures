//
//  RadarTarget.swift
//  Payment
//
//  Created by Akbarshah Jumanazarov on 4/4/25.
//

import SwiftUI

struct RadarTargetView: View {
    
    var image: UIImage? = nil
    var title: String
    
    var body: some View {
        VStack {
            Text(title)
                .opacity(0)
            
            Group {
                if let image {
                    Image(uiImage: image)
                        .resizable()
                } else {
                    Image(systemName: "person.fill")
                        .resizable()
                }
            }
            .scaledToFit()
            .frame(maxWidth: 32, maxHeight: 32)
            .frame(maxWidth: 80, maxHeight: 80)
            .foregroundStyle(.gray)
            .background(.white)
            .clipShape(.circle)
            
            Text(title)
        }
    }
}

#Preview {
    RadarTargetView(title: "User")
}
