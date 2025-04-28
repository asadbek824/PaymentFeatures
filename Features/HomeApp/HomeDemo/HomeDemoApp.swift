//
//  HomeAppApp.swift
//  HomeApp
//
//  Created by Asadbek Yoldoshev on 4/3/25.
//

import SwiftUI

@main
struct HomeAppApp: App {
    var body: some Scene {
        WindowGroup {
            HomeViewControllerRepresentable()
                .edgesIgnoringSafeArea(.all)
        }
    }
}
