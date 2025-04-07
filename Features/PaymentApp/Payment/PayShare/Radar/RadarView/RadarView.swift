//
//  ContentView.swift
//  TempDelete
//
//  Created by Akbarshah Jumanazarov on 4/2/25.
//

import SwiftUI

struct RadarView: View {
    
    @StateObject private var vm = RadarViewVM()
    
    var body: some View {
        ZStack {
            ForEach(vm.circles) { circle in
                Circle()
                    .fill(.appPrimary.opacity(circle.opacity))
                    .frame(width: circle.size, height: circle.size)
            }
        }
        .frame(maxWidth: UIScreen.main.bounds.width,
               maxHeight: UIScreen.main.bounds.height)
        .onAppear(perform: vm.startRadarAnimation)
    }
}

#Preview {
    RadarView()
}
